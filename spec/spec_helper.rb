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

RSpec.configure do |config|
  config.before(:each) do
    Validic.configure do |c|
      c.api_url = 'https://api.validic.com'
      c.api_version = 'v1'
      c.access_token = ENV['TEST_ORG_TOKEN']
      c.organization_id = ENV['TEST_ORG_ID']
    end
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
