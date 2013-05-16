# encoding: utf-8

module Validic
  module Weight

    ##
    # Get Weight Activities base on `access_token`
    # 
    # @return [Hashie::Mash] with list of Weight
    def get_weights(options={})
      options = {
        start_date: options[:start_date],
        end_date: options[:end_date]
      }
      response = get("/#{Validic.api_version}/weight.json", options)
      response if response
    end

    ##
    # Create Weight base on `access_token`
    # 
    # @return success
    def create_weight(options={})
      options = {
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
