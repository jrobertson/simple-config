#!/usr/bin/env ruby

# file: simple-config.rb

require 'kvx'


class SimpleConfig < Kvx
  
  
  def initialize(x, attributes: {})    

    @identifier = 'simple-config'
    
    if x.is_a? SimpleConfig then
      @to_h = x.to_h
    elsif x
      super(x, attributes: attributes)
    end
    
  end
                          
  alias write to_s
     
  private
  
  def parse_to_h(s)
    super(s, header_pattern: %r(^<\?simple-?config ))
  end    


end