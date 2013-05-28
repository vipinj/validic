# encoding: utf-8

module Validic
  module Fitness

    ##
    # Get Fitness Activities base on `access_token` and `organization_id`
    # 
    # @return [Hashie::Mash] with list of Fitness
    def get_fitnesses(options={})
      organization_id = options[:organization_id]
      options = {
        start_date: options[:start_date],
        end_date: options[:end_date],
        access_token: options[:access_token]
      }

      if options[:access_token] && organization_id
        response = get("/#{Validic.api_version}/organizations/#{organization_id}/fitness.json", options)
      else
        response = get("/#{Validic.api_version}/fitness.json", options)
      end
      response if response
    end

    ##
    # Create Fitness base on `access_token`
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
