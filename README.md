#Introducing the simple-config gem

    require 'simple-config'

    txt =<<EOF
    file_path: abc def
    description: xyx 123
    EOF

    SimpleConfig.parse txt
    #=> {:file_path=>"abc def", :description=>"xyx 123"}

    puts SimpleConfig.write(file_path: 'abc/132', description: '11 22 33')

output:

    file_path: abc/132
    description: 11 22 33

## Resources

* [jrobertson/simple-config Â· GitHub](https://github.com/jrobertson/simple-config)
