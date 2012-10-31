module Checkup
  class Model
    class << self
      def all
        @all ||= []
      end
    end
  
    attr_reader :trigger
    attr_reader :description
  
  
    def initialize(trigger, description, &block)
      @trigger = trigger.to_s
      @description = description.to_s
      
      @services = [] 
      
      instance_eval(&block) if block_given?
      Model.all << self
    end
    
    def service(name, &block)
      @services << get_class_from_scope(Service, name).new(self, &block)
    end
    
    def perform!
      @services.each do |service|
        service.perform
      end
    end
    
    def get_class_from_scope(scope, name)
      klass = scope
      name = name.to_s.sub(/^Checkup::Config::/, '')
      name.split('::').each do |chunk|
        klass = klass.const_get(chunk)
      end
      klass
    end
  end
end