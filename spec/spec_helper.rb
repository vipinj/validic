require 'validic'
require 'vcr'
require 'simplecov'
require 'simplecov-rcov'
require 'api_matchers'

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
  c.default_cassette_options = { record: :new_episodes }
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
      config.access_token     = 'ef617d9d3bb39b4112f60dc65ee40061165c1ab4375e3ea63896f63a7390c4db'
      config.organization_id  = '51aca5a06dedda916400002b'
    end
  end
end
