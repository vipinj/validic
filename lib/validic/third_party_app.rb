# encoding: utf-8

module Validic
  module ThirdPartyApp

    ##
    # Get List of Third Party Apps available base on `access_token` and organization_id
    # params[:org_id] required parameter
    # params[:access_token] required parameter
    # @return [Hashie::Mash] with list of Organization
    def get_apps(options={})
      options = {
        org_id: options[:org_id],
        access_token: options[:access_token]
      }
      response = get("/#{Validic.api_version}/apps.json", options)
      response if response
    end

    ##
    # Get User List of Third Party Synced Apps available base on `user_access_token`
    # 
    # params[:auth_token] User authentication parameter
    #
    # @return [Hashie::Mash] with list of Organization
    def get_synced_apps(options={})
      options = {
        auth_token: options[:user_access_token]
      }
      response = get("/#{Validic.api_version}/sync_apps.json", options)
      response if response
    end
  end
end
