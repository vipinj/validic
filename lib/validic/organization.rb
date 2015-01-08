# encoding: utf-8

module Validic
  module Organization

    ##
    # Get Organization base on `access_token` and organization_id
    #
    # @params :access_token
    # @return [Hashie::Mash] with list of Organization
    def get_organization(params={})
      organization_id = params[:organization_id] || Validic.organization_id
      get("/#{Validic.api_version}/organizations/#{organization_id}.json", params)
    end

  end
end
