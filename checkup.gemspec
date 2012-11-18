

require File.expand_path('lib/checkup/version')

Gem::Specification.new do |gem|
  gem.name        = 'checkup'
  gem.version     = Checkup::Version.current
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = 'Heiko Moeller'
  gem.email       = 'femaref@googlemail.com'
  gem.homepage    = 'https://github.com/Femaref/checkup'
  gem.summary     = ''

  
  gem.files         = %x[git ls-files].split("\n")
  gem.test_files    = %x[git ls-files -- {spec}/*].split("\n")
  gem.require_path  = 'lib'

  gem.executables   = ['checkup']

  gem.add_dependency 'thor',   ['~> 0.14.6']

end
