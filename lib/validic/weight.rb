# encoding: utf-8

module Validic
  module Weight

    ##
    # Get Weight Activities base on `access_token`
    # 
    # @return [Hashie::Mash] with list of Weight
    def get_weights(options={})
      organization_id = options[:organization_id]
      options = {
        start_date: options[:start_date],
        end_date: options[:end_date],
        access_token: options[:access_token]
      }

      if options[:access_token] && organization_id
        response = get("/#{Validic.api_version}/organizations/#{organization_id}/weight.json", options)
      else
        response = get("/#{Validic.api_version}/weight.json", options)
      end
    end

    ##
    # Create Weight base on `access_token`
    # 
    # @return success
    def create_weight(options={})
      options = {
        access_token: options[:access_token],
        weight: {
          timestamp: options[:timestamp],
          weight: options[:weight],
          bmi: options[:bmi],
          fat_percent: options[:fat_percent],
          mass_weight: options[:mass_weight],
          free_mass: options[:free_mass],
          source: options[:source]
        }
      }

      response = post("/#{Validic.api_version}/weight.json", options)
      response if response
    end

  end
end
