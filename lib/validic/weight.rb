# encoding: utf-8

module Validic
  module Weight

    ##
    # Get Weight Activities base on `access_token`
    # Default data fetched is from yesterday
    #
    # @params :organization_id - for organization specific
    # @params :user_id - for user specific
    #
    # @params :start_date - optional for date range beyond yesterday
    # @params :end_date - optional
    # @params :access_token - override for default access_token
    # @params :source - optional - data per source (e.g 'fitbit')
    # @params :expanded - optional - will show the raw data
    #
    # @return [Hashie::Mash] with list of Weight
    def get_weight(params={})
      get_endpoint(:weight, params)
    end

    alias :get_weights :get_weight

    ##
    # Create Weight base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @params :timestamp
    # @params :weight
    # @params :bmi
    # @params :fat_percent
    # @params :mass_weight
    # @params :free_mass
    # @params :source
    #
    # @return success
    def create_weight(user_id, data_id, options={})
      options = {
        user_id: user_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        weight: {
          data_id: data_id,
          timestamp: options[:timestamp],
          utc_offset: options[:utc_offset],
          weight: options[:weight] || 0,
          height: options[:height],
          free_mass: options[:free_mass],
          fat_percent: options[:fat_percent],
          mass_weight: options[:mass_weight],
          bmi: options[:bmi]
        }
      }

      response = post_to_validic('weight', options)
      response if response
    end

  end
end
