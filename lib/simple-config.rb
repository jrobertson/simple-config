#!/usr/bin/env ruby

# file: simple-config.rb

require 'kvx'


class SimpleConfig < Kvx
  
  
  def initialize(x, attributes: {}, auto_detect_type: true, comment_char: '#', 
                 debug: false)  

    @ignore_blank_lines = true
    @auto_detect_type = auto_detect_type
    
    if x.is_a? SimpleConfig then
      @to_h = x.to_h
    elsif x
      super(x, attributes: attributes, comment_char: comment_char, debug: debug)
    end
    
    @identifier = 'simple-config'    
    
  end
                          
  alias write to_s
     
  private
  
  def parse_to_h(s)
    h = super(s, header_pattern: %r(^<\?simple-?config\s*))
    @auto_detect_type ? scan2type(h) : h
  end    
  
  def find_type(v)
    
    puts 'v: ' + v.inspect if @debug

    if v[/^\d+$/] and v.to_i.to_s.length == v.length then v.to_i
    elsif v[/^\d+\.\d+$/] and v.to_f.to_s.length == v.length then v.to_f
    elsif v.downcase[/^(?:true|false|on|off|yes|no)$/]
      v.downcase[/^(?:true|on|yes)$/] ? true : false
    elsif v[/^\#.*\#$/] then
      Time.parse(v)
    else
      v
    end

  end

  def scan2type(h)

    h.each do |key, value|
      next if value.is_a? Array
      h[key] = value.is_a?(Hash) ? scan2type(value) : find_type(value)
    end

  end  

end
