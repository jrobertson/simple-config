Gem::Specification.new do |s|
  s.name = 'simple-config'
  s.version = '0.1.4'
  s.summary = 'simple-config'
    s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('line-tree') 
  s.signing_key = '../privatekeys/simple-config.pem'
  s.cert_chain  = ['gem-public_cert.pem']
end
