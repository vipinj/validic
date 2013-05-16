# encoding: utf-8

module Validic
  module Nutrition

    ##
    # Get Nutrition Activities base on `access_token`
    # 
    # @return [Hashie::Mash] with list of Nutrition
    def get_nutritions(options={})
      org_id = options[:org_id]
      options = {
        start_date: options[:start_date],
        end_date: options[:end_date],
        access_token: options[:access_token]
      }

      if options[:access_token] && org_id
        response = get("/#{Validic.api_version}/organizations/#{org_id}/nutrition.json", options)
      else
        response = get("/#{Validic.api_version}/nutrition.json", options)
      end
      response if response
    end

    ##
    # Create Nutrition base on `access_token`
    # 
    # @return success
    def create_nutrition(options={})
      options = {
        nutrition: {
          calories: options[:calories],
          carbohydrates: options[:carbohydrates],
          fat: options[:fat],
          fiber: options[:fiber],
          protein: options[:protein],
          sodium: options[:sodium],
          water: options[:water],
          timestamp: options[:timestamp],
          meal: options[:meal],
          source: options[:source]
        }
      }

      response = post("/#{Validic.api_version}/nutrition.json", options)
      response if response
    end

  end
end
