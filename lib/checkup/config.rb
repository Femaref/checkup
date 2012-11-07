module Checkup
  module Config
    DEFAULT_ROOT_PATH = '~/.checkup'

    class << self
      attr_accessor :root_path
    
    
      def add_dsl_constants!
        create_modules(
          self,
          [ 
            # Services
            ['Http'],
            # Notifiers
            ['Mail']
          ]
        )
      end

      def create_modules(scope, names)
        names.flatten.each do |name|
          if name.is_a?(Hash)
            name.each do |key, val|
              create_modules(get_or_create_empty_module(scope, key), [val])
            end
          else
            get_or_create_empty_module(scope, name)
          end
        end
      end

      def get_or_create_empty_module(scope, const)
        if scope.const_defined?(const)
          scope.const_get(const)
        else
          scope.const_set(const, Module.new)
        end
      end
    end
    
    add_dsl_constants!
  end
end