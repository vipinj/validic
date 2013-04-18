require "faraday"
require "faraday_middleware"
require "validic/client"
require "validic/version"

directory = File.expand_path(File.dirname(__FILE__))

module Validic

  class << self
    attr_accessor :api_url, :api_version, :access_token

    ##
    # Configure default
    #
    # @yield [Validic]
    def configure
      load_defaults
      yield self
      true
    end

    private

    def load_defaults
      self.api_url      ||= 'https://api.validic.com'
      self.api_version  ||= 'v1'
      self.access_token ||= 'DEMO_KEY'
    end
  end

end
