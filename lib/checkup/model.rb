module Checkup
  class Model
    class << self
      def all
        @all ||= []
      end

      def find(trigger)
        trigger = trigger.to_s
        all.each do |model|
          return model if model.trigger == trigger
        end
        raise Errors::Model::MissingTriggerError,
            "Could not find trigger '#{trigger}'."
      end

      def find_matching(trigger)
        regex = /^#{ trigger.to_s.gsub('*', '(.*)') }$/
        all.select {|model| regex =~ model.trigger }
      end
    end
  
    attr_reader :trigger
    attr_reader :description
  
  
    def initialize(trigger, description, &block)
      @trigger = trigger.to_s
      @description = description.to_s
      @started_at = Time.now
      
      @services = []
      @notifiers = []
      
      instance_eval(&block) if block_given?
      Model.all << self
    end
    
    def service(name, &block)
      @services << get_class_from_scope(Service, name).new(self, &block)
    end
    
    def notify_with(name, &block)
      @notifiers << get_class_from_scope(Notifier, name).new(self, &block)
    end
    
    def perform!
      log!(:started)
    
      
      @services.each do |service|
        service_result = true
        begin
          Logger.message "Starting service #{service.identifier}"
          service_result &&= service.perform!
        rescue StandardError => e
          service_result = false
          self.notify! :error, service, "#{service.identifier}: #{e.message}"
          Logger.error e.message
        end
        
        message = "Finished service #{service.identifier}"
        
        if !service_result
          message += " (with errors)"
          Logger.error message
        else
          Logger.message message
        end
        
      end      
      
      log!(:finished)
    end
    
    def get_class_from_scope(scope, name)
      klass = scope
      name = name.to_s.sub(/^Checkup::Config::/, '')
      name.split('::').each do |chunk|
        klass = klass.const_get(chunk)
      end
      klass
    end
    
    def log!(action)
      case action
      when :started
        Logger.message "Started model '(#{trigger})'!\n" +
            "[ checkup #{ Version.current } : #{ RUBY_DESCRIPTION } ]"

      when :finished
        msg = "Finished '(#{ trigger })' " +
              "Completed %s in #{ elapsed_time }"
        if Logger.has_warnings?
          Logger.warn msg % 'Successfully (with Warnings)'
        elsif Logger.has_errors?
          Logger.error msg % 'with errors'
        else
          Logger.message msg % 'Successfully'
        end
      end
    end
    
    def notify! (status, origin, message)
      @notifiers.each do |notifier|
        notifier.notify! status, origin, message
      end
    end

    def elapsed_time
      duration  = Time.now.to_i - @started_at.to_i
      hours     = duration / 3600
      remainder = duration - (hours * 3600)
      minutes   = remainder / 60
      seconds   = remainder - (minutes * 60)
      '%02d:%02d:%02d' % [hours, minutes, seconds]
    end
  end
end