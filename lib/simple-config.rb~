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

  def scan_to_h(raw_txt)
    
    txt, _ = RXFHelper.read(raw_txt)

    raw_a = LineTree.new(txt.gsub(/(^-*$)|(#.*)/,'').strip).to_a

    a = raw_a.map do |line|

      s = line.shift

      if line.any? then 
        
        r = scan_to_h(line.join("\n"))
        [s[/[^:]+/].to_sym, r]
        
      else
        
        value, name = s.split(':',2).reverse
        name ||= 'description'          
        
        [name.to_sym, value.to_s.strip]
      end

    end

    if a.count {|x| x.first  == :description } > 1 then
      return a.map(&:last)
    else
      @to_h = Hash[a]
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
