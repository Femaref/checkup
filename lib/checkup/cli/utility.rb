module Checkup
  module CLI
    class Utility < Thor
      include Thor::Actions
      
      method_option :trigger, :type => :string,  :required => true, :aliases => ['-t', '--triggers']
      method_option :root_path, :type => :string, :default => '', :aliases => '-r'
      desc 'perform', 'executes a named model'
      def perform
        root_path = options[:root_path]
        
        load root_path
        
        triggers = options[:trigger].split(",")
        triggers.map!(&:strip).map! {|t|
          t.include?('*') ? Model.find_matching(t) : t
        }.flatten!

        triggers.each do |trigger|
          model = Model.find(trigger)
          model.perform!
          Logger.clear!
        end
      end
      
      method_option :root_path, :type => :string, :default => '', :aliases => '-r'
      desc 'list', 'lists all models'
      def list
        root_path = options[:root_path]
        
        load root_path
        
        Model.all.each do |model|
          puts model.trigger
        end
      end
      
      private
      
      def load (path)
        Dir[File.join(path, "*")].each do |file|
          Checkup::Config.class_eval File.read(File.expand_path(File.basename(file), path))
        end
      end
      
    end
  end
end