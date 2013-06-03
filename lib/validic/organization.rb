# encoding: utf-8

module Validic
  module Organization

    ##
    # Get Organization base on `access_token` and organization_id
    # 
    # @params :access_token
    # @return [Hashie::Mash] with list of Organization
    def get_organization(options={})
      organization_id = options[:organization_id]
      options = {
        access_token: options[:access_token]
      }
      response = get("/#{Validic.api_version}/organizations/#{organization_id}.json", options)
      response if response
    end

    ##
    # Get Users base on `access_token` and organization_id
    # 
    # @params :status - optional (active or inactive) default :all
    # @params :access_token - optional
    # @params :start_date - optional
    # @params :end_date - optional
    # @params :offset - optional
    # @params :limit - optional
    #
    # @return [Hashie::Mash] with list of Organization
    def get_users(options={})
      organization_id = options[:organization_id]
      options = {
        access_token: options[:access_token],
        start_data: options[:start_date],
        end_date: options[:end_date],
        offset: options[:offset],
        limit: options[:limit],
        status: options[:status]
      }
      response = get("/#{Validic.api_version}/organizations/#{organization_id}/users.json", options)
      response if response
    end

  end
end
