# encoding: utf-8

module Checkup
  module Service
    class Base
      include Checkup::Configuration::Helpers
    
      def initialize(model)
        @model = model
        load_defaults!
        
        yield self
      end
      
      def perform!
      end
      
      def identifier
      end
      
    end
  end
end