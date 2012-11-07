require 'erb'

module Checkup
  class Template
   
    attr_accessor :binding

    def initialize(object = nil)
      if object.is_a?(Binding)
        @binding = object
      elsif object.is_a?(Hash)
        @binding = Checkup::Binder.new(object).get_binding
      else
        @binding = nil
      end
    end

    def render(file)
      puts result(file)
    end

    def result(file)
      ERB.new(file_contents(file), nil, '<>').result(binding)
    end

  private

    def file_contents(file)
      File.read(File.join(Checkup::TEMPLATE_PATH, file))
    end

  end
end
