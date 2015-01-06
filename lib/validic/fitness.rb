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
    def create_fitness(options={})
      options = {
        access_token: options[:access_token],
        fitness: {
          timestamp: options[:timestamp],
          primary_type: options[:primary_type],
          intensity: options[:intensity],
          start_time: options[:start_time],
          total_distance: options[:total_distance],
          duration: options[:duration],
          source: options[:source]
        }
      }

      response = post("/#{Validic.api_version}/fitness.json", options)
      response if response
    end

  end
end
