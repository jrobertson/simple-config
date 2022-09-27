Gem::Specification.new do |s|
  s.name = 'simple-config'
  s.version = '0.7.3'
  s.summary = 'Simple-config makes it convenient to read or write a ' + 
      'config file as simple as possible'
  s.authors = ['James Robertson']
  s.files = Dir['lib/simple-config.rb']
  s.add_runtime_dependency('kvx', '~> 1.1', '>=1.1.3')
  s.signing_key = '../privatekeys/simple-config.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'digital.robertson@gmail.com'
  s.homepage = 'https://github.com/jrobertson/simple-config'
  s.required_ruby_version = '>= 2.1.2'
end
