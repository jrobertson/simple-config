Introducing the Simple-config gem

    require 'simple-config'

    txt =<<EOF
    file_path: abc def
    description: xyx 123
    EOF

    sc = SimpleConfig.new(txt)
    sc.to_h #=> {:file_path=>"abc def", :description=>"xyx 123"}
    puts sc.write

Output:

<pre>
file_path: abc def
description: xyx 123
</pre>

## Resources

* ?simple-config https://rubygems.org/gems/simple-config?

simpleconfig gem
