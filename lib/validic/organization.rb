# encoding: utf-8

module Validic
  module Organization

    ##
    # Get Organization base on `access_token` and organization_id
    # 
    # @return [Hashie::Mash] with list of Organization
    def get_organization(options={})
      org_id = options[:org_id]
      options = {
        access_token: options[:access_token],
      }
      response = get("/#{Validic.api_version}/organizations/#{org_id}.json", options)
      response if response
    end

  end
end
