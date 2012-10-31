# encoding: utf-8

module Checkup
  module Configuration
    module Helpers

      ##
      # Finds all the object's getter methods and checks the global
      # configuration for these methods, if they respond then they will
      # assign the object's attribute(s) to that particular global configuration's attribute
      def load_defaults!
        module_names  = self.class.name.split('::')[1..-1]
        configuration = Checkup::Configuration
        module_names.each do |module_name|
          configuration = configuration.const_get(module_name)
        end

        getter_methods.each do |attribute|
          if configuration.respond_to?(attribute)
            self.send("#{attribute}=", configuration.send(attribute))
          end
        end
      end

      ##
      # Clears all the defaults that may have been set by the user
      def clear_defaults!
        setter_methods.each do |method|
          self.send(method, nil)
        end
      end

      private

      ##
      # Returns an Array of the setter methods (as String)
      def setter_methods
        methods.map do |method|
          method = method.to_s
          method if method =~ /^\w(\w|\d|\_)+\=$/ and method != 'taguri='
        end.compact
      end

      ##
      # Returns an Array of getter methods (as String)
      def getter_methods
        setter_methods.map {|method| method.sub('=','') }
      end

    end
  end
end
