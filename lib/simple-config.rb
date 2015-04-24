#!/usr/bin/env ruby

# file: simple-config.rb

require 'kvx'


class SimpleConfig < Kvx
  
  attr_reader :to_h, :to_s
  
  def initialize(x, attributes: {})    

    if x.is_a? SimpleConfig then
      @to_h = x.to_h
    elsif x
      super(x, attributes: attributes)
    end
    
  end
                          
  def write(h=nil, header: @header)
    
    @to_h = h || @to_h

    header = ''
    
    if @header then
      
      header = '<?simple-config'
      header += ' ' + @attributes.map {|x| "%s='%s'" % x }.join(' ')
      header += "?>\n"
    end
    
    @to_s = header + scan_to_s(@to_h)

  end  
     
  private
  
  def parse_to_h(s)
    super(s, header_pattern: %r(^<\?simple-?config ))
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