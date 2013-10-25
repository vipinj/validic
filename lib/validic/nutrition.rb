# encoding: utf-8

module Validic
  module Nutrition

    ##
    # Get Nutrition Activities base on `access_token`
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
    # @return [Hashie::Mash] with list of Nutrition
    def get_nutritions(options={})
      organization_id = options[:organization_id]
      user_id = options[:user_id]
      options = {
        start_date: options[:start_date],
        end_date: options[:end_date],
        access_token: options[:access_token],
        source: options[:source],
        expanded: options[:expanded],
        limit: options[:limit],
        page: options[:page],
        offset: options[:offset]
      }

      if organization_id
        response = get("/#{Validic.api_version}/organizations/#{organization_id}/nutrition.json", options)
      elsif user_id
        response = get("/#{Validic.api_version}/users/#{user_id}/nutrition.json", options)
      else
        response = get("/#{Validic.api_version}/nutrition.json", options)
      end
      response if response
    end

    ##
    # Create Nutrition base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    # 
    # @params :calories
    # @params :carbohydrates
    # @params :fat
    # @params :fiber
    # @params :protein
    # @params :sodium
    # @params :water
    # @params :timestamp
    # @params :meal
    # @params :source
    #
    # @return success
    def create_nutrition(options={})
      options = {
        access_token: options[:access_token],
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
