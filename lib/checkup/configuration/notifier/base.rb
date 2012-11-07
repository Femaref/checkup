module Checkup
  module Configuration
    module Notifier
      class Base < Configuration::Base
        class << self
          attr_accessor :on_success       
          attr_accessor :on_warning
          attr_accessor :on_failure
        end
      end
    end
  end
end