# encoding: utf-8

module Validic
  module Fitness

    ##
    # Get Fitness Activities base on `access_token`
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
    # @return [Hashie::Mash] with list of Fitness
    def get_fitness(params={})
      get_endpoint(:fitness, params)
    end

    alias :get_fitnesses :get_fitness

    ##
    # Create Fitness base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @params :timestamp
    # @params :primary_type
    # @params :intensity
    # @params :start_time
    # @params :total_distance
    # @params :duration
    # @params :source
    #
    # @return success
    def create_fitness(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        fitness: {
          activity_id: activity_id,
          timestamp: options[:timestamp] || DateTime.now.utc.to_s(:iso8601),
          utc_offset: options[:utc_offset],
          type: options[:type] || 'General',
          intensity: options[:intensity],
          start_time: options[:start_time],
          distance: options[:distance],
          duration: options[:duration],
          calories: options[:calories],
          extras: options[:extras]
        }
      }

      response = post_to_validic('fitness', options)
      response if response
    end

    ##
    # Update Fitness base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @params :timestamp
    # @params :primary_type
    # @params :intensity
    # @params :start_time
    # @params :total_distance
    # @params :duration
    # @params :source
    #
    # @return success
    def update_fitness(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        activity_id: activity_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        fitness: {
          activity_id: activity_id,
          timestamp: options[:timestamp] || DateTime.now.utc.to_s(:iso8601),
          utc_offset: options[:utc_offset],
          type: options[:type] || 'General',
          intensity: options[:intensity],
          start_time: options[:start_time],
          distance: options[:distance],
          duration: options[:duration],
          calories: options[:calories],
          extras: options[:extras]
        }
      }

      response = put_to_validic('fitness', options)
      response if response
    end

    ##
    # Delete Fitness record
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @return success
    def delete_fitness(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        activity_id: activity_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id
      }

      response = delete_to_validic('fitness', options)
      response if response
    end

  end
end
