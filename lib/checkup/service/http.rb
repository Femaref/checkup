# encoding: utf-8

Checkup::Dependency.load('httparty')

module Checkup
  module Service
    class Http < Base
      attr_accessor :url
      attr_accessor :method
      attr_accessor :expected_code
      attr_accessor :expected_response
      
      def perform!
        super
        
        response = ::HTTParty.send(self.method.to_sym, self.url)
        
        Logger.message "Got #{response.code} from #{self.url}"
        
        result = response.code == self.expected_code
        
        if !result
          raise Checkup::Errors::Service::Http::AssertError, 
            "Expected code #{self.expected_code}, got #{response.code}"
        end
        
        if self.expected_response.is_a? Regexp
          result &&= !!self.expected_response.match(response.body)
          if !result
            raise Checkup::Errors::Service::Http::RegexpError,
              "Expected match for #{self.expected_response.to_s}"
          end
        else
          result &&= self.expected_response == response.body
            raise Checkup::Errors::Service::Http::AssertError, 
              "Expected response #{self.expected_response}"
        end
        
        return result
      end
      
      def identifier
        return "#{self.method} #{self.url}"
      end
    end
  end
end