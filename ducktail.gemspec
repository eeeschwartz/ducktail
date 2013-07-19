Gem::Specification.new do |s|
  s.name         = 'ducktail'
  s.version      = '0.0.1'
  s.date         = '2013-07-19'
  s.summary      = 'Ducktail - tail -f logs over the web'
  s.description  = 'A simple eventmachine-based utility to tail -f logs over http'
  s.authors      = ['Erik Schwartz']
  s.email        = 'junkyarddolphin@gmail.com'
  s.files        = ['lib/ducktail.rb']
  s.license      = 'MIT'
  s.homepage     = 'http://github.com/eeeschwartz/ducktail'
  s.executables << 'ducktail'
end
