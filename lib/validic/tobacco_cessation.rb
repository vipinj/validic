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
    # @params :source - optional - data per source (e.g 'fitbit')
    # @params :expanded - optional - will show the raw data
    #
    # @return [Hashie::Mash] with list of TobaccoCessation
    def get_tobacco_cessations(params={})
      get_endpoint(:tobacco_cessation, params)
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
    def create_tobacco_cessation(user_id, options={})
      options = {
        user_id: user_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        tobacco_cessation: {
          timestamp: options[:timestamp],
          utc_offset: options[:utc_offset],
          cigarettes_allowed: options[:cigarettes_allowed] || 0,
          cigarettes_smoked: options[:cigarettes_smoked] || 0,
          cravings: options[:cravings] || 0,
          last_smoked: options[:last_smoked] || DateTime.now.utc.to_s(:iso8601)
        }
      }

      response = post_to_validic('tobacco_cessation', options)
      response if response
    end

  end
end
