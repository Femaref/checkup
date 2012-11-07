module Checkup
  module Notifier
    class Base
      include Checkup::Configuration::Helpers
      
      attr_accessor :on_success
      alias :notify_on_success? :on_success
      
      attr_accessor :on_warning
      alias :notify_on_warning? :on_warning

      attr_accessor :on_failure
      alias :notify_on_failure? :on_failure
    
      def initialize(model)
        @model = model
        load_defaults!
        
        yield self
      end
      
      def perform!
      end      
    end
  end
end