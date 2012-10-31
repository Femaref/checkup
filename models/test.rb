Checkup::Model.new(:test, 'test') do
  service Http do |service|
    service.url = 'http://google.de'
    service.method = :get
    service.expected_code = 200
    service.expected_response = /.+http.+/
  end
end