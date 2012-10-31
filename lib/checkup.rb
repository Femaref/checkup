# encoding: utf-8

# Load Ruby Core Libraries
require 'rubygems'

# Attempt load to Thor library
begin
  require 'thor'
rescue LoadError
  puts 'Checkup requires the Thor library'
  exit 1
end

module Checkup
  LIBRARY_PATH = File.join(File.dirname(__FILE__), 'checkup')
  CLI_PATH = File.join(LIBRARY_PATH, 'cli')
  CONFIGURATION_PATH = File.join(LIBRARY_PATH, 'configuration')
  
  autoload :Model, File.join(LIBRARY_PATH, 'model')
  autoload :Config, File.join(LIBRARY_PATH, 'config')
  
  module CLI
    autoload :Helpers, File.join(CLI_PATH, 'helpers')
    autoload :Utility, File.join(CLI_PATH, 'utility')
  end
  
  module Configuration
    autoload :Base, File.join(CONFIGURATION_PATH, 'base')
    autoload :Helpers,  File.join(CONFIGURATION_PATH, 'helpers')
    
    module Service
      autoload :Base, File.join(CONFIGURATION_PATH, 'service', 'base')
      autoload :Http, File.join(CONFIGURATION_PATH, 'service', 'http')
    end
  end
  
  module Service
    autoload :Base, File.join(LIBRARY_PATH, 'service', 'base')
    autoload :Http, File.join(LIBRARY_PATH, 'service', 'http')
  end
end