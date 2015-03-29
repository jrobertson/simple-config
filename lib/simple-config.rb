#!/usr/bin/env ruby

# file: simple-config.rb

require 'line-tree'
require 'rxfhelper'


class SimpleConfig
  
  attr_reader :to_h, :to_s
  
  def initialize(x=nil)    

    m = {:String => :parse_to_h, :Hash => :write, :SimpleConfig => :passthru}
    method(m[x.class.to_s.to_sym]).call(x) if x
  end
  
  def parse(t=nil)
    parse_to_h(t || @to_s)
  end  
                        
  def write(h=nil)
    @to_h = h || @to_h
    scan_to_s @to_h
  end
     
  private

  def parse_to_h(s)

    txt, _ = RXFHelper.read(s)
    scan_to_h(txt)
  end
  
  def passthru(x)
    initialize x.to_h
  end
  
  def pretty_print(a, indent='')
    
    a.map {|x|  (x.is_a?(String) or x.nil?) ? x.to_s : pretty_print(x, indent + '  ')}\
                                                          .join("\n" + indent)
  end
  
  
  def scan_to_h(txt)

    raw_a = LineTree.new(txt.gsub(/(^-*$)|(#.*)/,'').strip, 
                                              ignore_blank_lines: false).to_a
    
    # if there are any orphan lines which aren't nested underneath a 
    #   label, they will be fixed using the following statement
    
    a = raw_a.chunk {|x| x[0][/^\w+:|.*/]}.inject([]) do |r,y|
      if r.last and !y.first[/\w+:/] then
        r.last << y.last[-1]
      else
        r << y.last[-1]
      end
      r
    end
    

    @to_h = a.inject({}) do |r, line|
           
      s = line.shift
      

      if line.join.length > 0 then 

        r2 = if line[0][0][/^\w+: /] then

          scan_to_h(line.join("\n"))
          
        else

          desc = pretty_print(line).split(/\n(?=\w+: )/)         

          txt2, remaining = desc

          h = txt2.lines.inject([]) do |r, x| 
            x.chomp!
            x.length > 0 ?  r << x : r
          end
          
          r3 = {description: txt2, items: h}

          if remaining then

            r3.merge!(scan_to_h remaining + "\n ")
          end
          
          r3
        end

        r.merge({s[/[^:]+/].to_sym => r2})
        
      else
        
        value, name = s.split(': ',2).reverse
        name ||= 'description'          
        
        r.merge({name.to_sym => value.to_s})
      end     

    end    

  end   

  def scan_to_s(h, indent='')    
    
    a = h.inject([]) do |r, x|
      if x.last.is_a? Hash then
        r << x.first.to_s + ":\n" + scan_to_s(x.last, '  ')
      else
        r << "%s%s: %s" % [indent, *x]
      end
    end
    
    @to_s = a.join("\n")
  end

end