# encoding: utf-8

module Checkup
  module Configuration
    module Service
      class Http < Base
        class << self
          attr_accessor :url
          attr_accessor :method
          attr_accessor :expected_code
          attr_accessor :expected_response
        end
      end
    end
  end
end