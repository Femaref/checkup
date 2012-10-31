# encoding: utf-8

module Checkup
  module Service
    class Base
      include Checkup::Configuration::Helpers
    
      def initialize(model)
        @model = model
        load_defaults!
      end
      
      def perform!
      end
      
    end
  end
end