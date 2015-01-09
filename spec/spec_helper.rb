require 'validic'
require 'vcr'
require 'pry'
require 'dotenv'
Dotenv.load

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'spec/cassette'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.filter_sensitive_data('acme_id')    { ENV['TEST_ORG_ID'] }
  c.filter_sensitive_data('acme_token') { ENV['TEST_ORG_TOKEN'] }
  c.filter_sensitive_data('acme_user')  { ENV['TEST_USER_ID'] }
  c.filter_sensitive_data('acme_auth')  { ENV['TEST_USER_AUTHENTICATION_TOKEN'] }
  c.filter_sensitive_data('hy_id')      { ENV['PARTNER_ORG_ID'] }
  c.filter_sensitive_data('hy-token')   { ENV['PARTNER_ACCESS_TOKEN'] }
  c.filter_sensitive_data('hy-user')    { ENV['PARTNER_USER_ID'] }
end

RSpec.configure do |c|
  c.before(:each) do
    Validic.configure do |config|
      # This is using ACME Corp Credentials as per Documentation
      config.api_url          = 'https://api.validic.com'
      config.api_version      = 'v1'
      config.access_token     = ENV['TEST_ORG_TOKEN']
      config.organization_id  = ENV['TEST_ORG_ID']
    end
  end
end
