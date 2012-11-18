Checkup is a simple service up check. Currently only supports http check and mail notification.

Sample configuration file:

    Checkup::Model.new(:foo, 'foo') do
      service Http do |service|
        service.url = 'http://example.de'
        service.method = :get
        service.expected_code = 200
        service.expected_response = /.+html.+/
      end
      
      notify_with Mail do |mail|
        mail.delivery_method      = :sendmail
        mail.from                 = 'info@example.de'
        mail.to                   = 'bar@example.de'
      
        mail.on_success = true
        mail.on_warning = true
        mail.on_failure = true
      end
    end
    
You can execute this via:

    checkup perform -r /path/to/models -t foo
    
With [whenever](https://github.com/javan/whenever), you can create a crontab to use this regulary:

    every 5.minutes do
      command "checkup perform -r /var/checkup -t foo"
    end
    
This can be added to the crontab of the current user with `whenever --update-crontab`.