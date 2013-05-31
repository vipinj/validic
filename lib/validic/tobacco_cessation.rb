# encoding: utf-8

module Validic
  module TobaccoCessation

    ##
    # Get TobaccoCessation Activities base on `access_token`
    # Default data fetched is from yesterday
    #
    # @params :organization_id - for organization specific
    # @params :user_id - for user specific
    #
    # @params :start_date - optional
    # @params :end_date - optional
    # @params :access_token - override for default access_token
    # 
    # @return [Hashie::Mash] with list of TobaccoCessation
    def get_tobacco_cessations(options={})
      organization_id = options[:organization_id]
      user_id = options[:user_id]
      options = {
        start_date: options[:start_date],
        end_date: options[:end_date],
        access_token: options[:access_token]
      }

      if organization_id
        response = get("/#{Validic.api_version}/organizations/#{organization_id}/tobacco_cessation.json", options)
      elsif user_id
        response = get("/#{Validic.api_version}/users/#{user_id}/tobacco_cessation.json", options)
      else
        response = get("/#{Validic.api_version}/tobacco_cessation.json", options)
      end
      response if response
    end

    ##
    # Create TobaccoCessation base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    # 
    # @params :cigarettes_allowed
    # @params :cigarettes_smoked
    # @params :cravings
    # @params :last_smoked
    # @params :timestamp
    # @params :source
    #
    # @return success
    def create_tobacco_cessation(options={})
      options = {
        access_token: options[:access_token],
        tobacco_cessation: {
          cigarettes_allowed: options[:cigarettes_allowed],
          cigarettes_smoked: options[:cigarettes_smoked],
          cravings: options[:cravings],
          last_smoked: options[:last_smoked],
          timestamp: options[:timestamp],
          source: options[:source]
        }
      }

      response = post("/#{Validic.api_version}/tobacco_cessation.json", options)
      response if response
    end

  end
end
