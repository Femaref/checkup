require 'rubygems'

begin
  require 'thor'
rescue LoadError
  puts 'Checkup requires the Thor library'
  exit 1
end

module Checkup
  LIBRARY_PATH = File.join(File.dirname(__FILE__), 'checkup')
  TEMPLATE_PATH = File.join(File.dirname(__FILE__), '..', 'templates')
  CLI_PATH = File.join(LIBRARY_PATH, 'cli')
  CONFIGURATION_PATH = File.join(LIBRARY_PATH, 'configuration')
  
  autoload :Binder, File.join(LIBRARY_PATH, 'binder')
  autoload :Config, File.join(LIBRARY_PATH, 'config')
  autoload :Dependency, File.join(LIBRARY_PATH, 'dependency')
  autoload :Errors, File.join(LIBRARY_PATH, 'errors')
  autoload :Logger, File.join(LIBRARY_PATH, 'logger')
  autoload :Model, File.join(LIBRARY_PATH, 'model')
  autoload :Template, File.join(LIBRARY_PATH, 'template')
  autoload :Version, File.join(LIBRARY_PATH, 'version')
  
  module CLI
    autoload :Utility, File.join(CLI_PATH, 'utility')
  end
  
  module Configuration
    autoload :Base, File.join(CONFIGURATION_PATH, 'base')
    autoload :Helpers,  File.join(CONFIGURATION_PATH, 'helpers')
    
    module Notifier
      autoload :Base, File.join(CONFIGURATION_PATH, 'notifier', 'base')
      autoload :Mail, File.join(CONFIGURATION_PATH, 'notifier', 'mail')
    end
    
    module Service
      autoload :Base, File.join(CONFIGURATION_PATH, 'service', 'base')
      autoload :Http, File.join(CONFIGURATION_PATH, 'service', 'http')
    end
  end
  
  module Notifier
    autoload :Base, File.join(LIBRARY_PATH, 'notifier', 'base')
    autoload :Mail, File.join(LIBRARY_PATH, 'notifier', 'mail')
  end
  
  module Service
    autoload :Base, File.join(LIBRARY_PATH, 'service', 'base')
    autoload :Http, File.join(LIBRARY_PATH, 'service', 'http')
  end
end