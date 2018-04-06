#!/usr/bin/env ruby

# file: simple-config.rb

require 'kvx'


class SimpleConfig < Kvx
  
  
  def initialize(x, attributes: {}, debug: false)    

    @ignore_blank_lines = true
    
    if x.is_a? SimpleConfig then
      @to_h = x.to_h
    elsif x
      super(x, attributes: attributes, debug: debug)
    end
    
    @identifier = 'simple-config'    
    
  end
                          
  alias write to_s
     
  private
  
  def parse_to_h(s)
    super(s, header_pattern: %r(^<\?simple-?config\s*))
  end    


end
