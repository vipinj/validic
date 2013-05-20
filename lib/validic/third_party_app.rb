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
    # Get User List of Third Party Synced Apps available base on `access_token` and organization_id
    # params[:org_id] required parameter
    # params[:access_token] required parameter
    # @return [Hashie::Mash] with list of Organization

    # def get_synced_apps(options={})
    #   options = {
    #     org_id: options[:org_id],
    #     access_token: options[:access_token],
    #     user_access_token: options[:user_access_token]
    #   }
    #   response = get("/#{Validic.api_version}/synced_apps.json", options)
    #   response if response
    # end
  end
end
