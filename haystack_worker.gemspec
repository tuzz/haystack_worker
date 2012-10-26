Gem::Specification.new do |s|
  s.name        = 'haystack_worker'
  s.version     = '0.0.1.alpha'
  s.summary     = 'Summary'
  s.description = 'Description'
  s.author      = 'Christopher Patuzzo'
  s.email       = 'chris.patuzzo@gmail.com'
  s.homepage    = 'https://github.com/cpatuzzo/haystack_worker'
  s.files       = ['README.md'] + Dir['lib/**/*.*'] + Dir['ext/**/*.{c,h,rb}']
  s.extensions  = ['ext/haystack_worker/extconf.rb']
  s.executables = ['haystack']

  s.add_development_dependency 'rspec'
end
