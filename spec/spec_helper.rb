require 'validic'
require 'vcr'
require 'simplecov'
require 'simplecov-rcov'
require 'api_matchers'
require 'pry'
require 'dotenv'
Dotenv.load

class SimpleCov::Formatter::MergedFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end

SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
SimpleCov.start do
  add_filter '/vendor'
end

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
  c.include APIMatchers::RSpecMatchers

  c.treat_symbols_as_metadata_keys_with_true_values = true

  ##
  # Add gem specific configuration for easy access
  #
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
