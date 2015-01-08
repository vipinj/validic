# encoding: utf-8

module Validic
  module Routine

    ##
    # Get Routine Activities base on `access_token`
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
    # @return [Hashie::Mash] with list of Routine
    def get_routine(params={})
      get_endpoint(:routine, params)
    end

    alias :get_routines :get_routine

    ##
    # Create Routine base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @params :steps
    # @params :stairs_climbed
    # @params :calories_burned
    # @params :calories_consumed
    # @params :timestamp
    # @params :source
    #
    # @return success
    def create_routine(user_id, options={})
      options = {
        user_id: user_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        routine: {
          activity_id: options[:activity_id],
          timestamp: options[:timestamp],
          utc_offset: options[:utc_offset],
          steps: options[:steps],
          distance: options[:distance],
          floors: options[:floors],
          elevation: options[:elevation],
          calories_burned: options[:calories_burned]
        },
      }

      response = post_to_validic('routine', options )
      response if response
    end

  end
end
