# encoding: utf-8

module Checkup
  # Small dependency loader, so we don't have to require all possible gems in the Gemfile
  class Dependency  
    def self.all
      @all ||= {
        'mail' => {
          :require => 'mail',
          :version => '>= 2.4.0',
          :for     => 'Sending Emails (Mail Notifier)'
        },
        'httparty' => {
          :require => 'httparty',
          :version => '>= 0',
          :for     => 'Http up check'
        }
      }
    end
    
    def self.load (name)
      begin
        gem(name, all[name][:version])
        require(all[name][:require])
      rescue LoadError
        Logger.error Errors::Dependency::LoadError.new(<<-EOS)
          Dependency missing
          Dependency required for:
          #{all[name][:for]}
          To install the gem, issue the following command:
          > gem install #{name} -v '#{all[name][:version]}'
          Please try again after installing the missing dependency.
        EOS
        exit 1
      end
    end
  end
end