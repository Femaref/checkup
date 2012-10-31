# encoding: utf-8

require File.expand_path('lib/checkup/version')

Gem::Specification.new do |gem|

  ##
  # General configuration / information
  gem.name        = 'checkup'
  gem.version     = Checkup::Version.current
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = 'Heiko Moeller'
  gem.email       = 'femaref@googlemail.com'
  gem.homepage    = 'http://rubygems.org/gems/checkup'
  gem.summary     = ''

  ##
  # Files and folder that need to be compiled in to the Ruby Gem
  gem.files         = %x[git ls-files].split("\n")
  gem.test_files    = %x[git ls-files -- {spec}/*].split("\n")
  gem.require_path  = 'lib'

  ##
  # The Backup CLI executable
  gem.executables   = ['checkup']

  ##
  # Gem dependencies
  # gem.add_dependency 'thor',   ['~> 0.14.6']
  gem.add_dependency 'httparty'

end
