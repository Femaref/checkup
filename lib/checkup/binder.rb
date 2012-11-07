module Checkup
  class Binder
    def initialize(key_and_values)
      key_and_values.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
    
    def get_binding
      binding
    end

  end
end  