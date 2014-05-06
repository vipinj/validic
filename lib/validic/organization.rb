# encoding: utf-8

module Validic
  module Organization

    ##
    # Get Organization base on `access_token` and organization_id
    # 
    # @params :access_token
    # @return [Hashie::Mash] with list of Organization
    def get_organization(params={})
      params = extract_params(params)
      get("/#{Validic.api_version}/organizations/#{Validic.organization_id}.json", params)
    end

  end
end
