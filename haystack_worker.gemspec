Gem::Specification.new do |s|
  s.name        = 'haystack_worker'
  s.version     = '1.0.2'
  s.summary     = 'Haystack Worker'
  s.description = 'Works on behalf of a haystack server.'
  s.author      = 'Christopher Patuzzo'
  s.email       = 'chris.patuzzo@gmail.com'
  s.homepage    = 'https://github.com/cpatuzzo/haystack_worker'
  s.files       = ['README.md'] + Dir['lib/**/*.*'] + Dir['ext/**/*.{c,h,rb}']
  s.extensions  = ['ext/haystack_worker/extconf.rb']
  s.executables = ['haystack']

  s.add_dependency 'json'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'fakeweb'
  s.add_development_dependency 'rack'
end
