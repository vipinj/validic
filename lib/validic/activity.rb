# encoding: utf-8

module Validic
  module Activity

    ##
    # Get Activity base on `access_token`
    # Default data fetched is from yesterday
    #
    # @params :organization_id - for organization specific fitness
    # @params :start_date - optional
    # @params :end_date - optional
    # @params :access_token - override for default access_token
    # 
    # @return [Hashie::Mash] with list of Activity
    def get_activities(options={})
      organization_id = options[:organization_id]
      options = {
        access_token: options[:access_token],
        start_date: options[:start_date],
        end_date: options[:end_date]
      }

      if organization_id
        response = get("/#{Validic.api_version}/organizations/#{organization_id}/fitness.json", options)
      else
        response = get("/#{Validic.api_version}/fitness.json", options)
      end
      
      response if response
    end

  end
end
