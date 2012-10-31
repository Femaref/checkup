# encoding: utf-8

module Checkup
  module Service
    class Http < Base
      attr_accessor :url
      attr_accessor :method
      attr_accessor :expected_code
      attr_accessor :expected_response
      
      def perform!
        super
        
        response = HTTParty.send(self.method.to_sym, self.url)
        
        result = response.code == self.expected_code
        
        if self.expected_response.is_a? Regexp
          result &&= !!self.expected_response.match(response.body)
        else
          result &&= self.expected_response == response.body
        end
      end
    end
  end
end