#!/usr/bin/env ruby

# file: simple-config.rb

require 'line-tree'
require 'rxfhelper'


class SimpleConfig
  
  attr_reader :to_h, :to_s
  
  def initialize(x=nil)    
    m = {:String => :scan_to_h, :Hash => :scan_to_s}
    method(m[x.class.to_s.to_sym]).call(x) if x
  end
  
  def parse(t=nil)
    scan_to_h(t || @to_s)
  end  
                        
  def write(h=nil)
    scan_to_s h || @to_h
  end
     
  private

  
  def pretty_print(a, indent='')
    
    a.map {|x|  x.is_a?(String) ? x : pretty_print(x, indent + '  ')}\
                                                          .join("\n" + indent)
  end
  
  
  def scan_to_h(raw_txt)
    
    txt, _ = RXFHelper.read(raw_txt)
    raw_a = LineTree.new(txt.gsub(/(^-*$)|(#.*)/,'').strip).to_a

    @to_h = raw_a.inject({}) do |r, line|

      s = line.shift

      if line.any? then 
                
        r2 = if line[0][0][/^\w+:/] then
          scan_to_h(line.join("\n"))
        else

          desc = pretty_print(line).split(/\n(?=\w+:)/)         
          txt, remaining = desc

          r3 = {description: txt, items: txt.lines.map(&:chomp)}

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
