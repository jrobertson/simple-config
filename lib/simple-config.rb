#!/usr/bin/env ruby[4~

# file: simple-config.rb

require 'line-tree'

class SimpleConfig

  def self.parse(txt)

    raw_a = LineTree.new(txt.gsub(/^-*$/m,'')).to_a

    a = raw_a.map do |line|

      s = line.is_a?(Array) ? line[0] : line
      value, name = s.split(':',2).reverse
      name ||= 'description'
        
      [name.to_sym, value.to_s.strip]

    end

    Hash[a]
  end
end
