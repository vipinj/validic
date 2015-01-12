require "faraday"
require "faraday_middleware"
require "validic/client"
require "validic/version"

module Validic

  class << self
    attr_accessor :api_url,
      :api_version,
      :access_token,
      :organization_id

    ##
    # Configure default
    #
    # @yield [Validic]
    def configure
      yield self
      true
    end
  end
end
