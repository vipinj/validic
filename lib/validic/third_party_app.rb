# encoding: utf-8

module Validic
  module ThirdPartyApp

    ##
    # Get Organization base on `access_token` and organization_id
    # 
    # @return [Hashie::Mash] with list of Organization
    def get_apps(options={})
      response = get("/#{Validic.api_version}/apps.json", options)
      response if response
    end

  end
end
