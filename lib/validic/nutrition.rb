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
    def get_nutritions(params={})
      get_endpoint(:nutrition, params)
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
    def create_nutrition(user_id, entry_id, options={})
      options = {
        user_id: user_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        nutrition: {
          entry_id: entry_id,
          timestamp: options[:timestamp] || DateTime.now.new_offset(0).iso8601,
          utc_offset: options[:utc_offset],
          calories: options[:calories] || 0,
          carbohydrates: options[:carbohydrates],
          fat: options[:fat],
          fiber: options[:fiber],
          protein: options[:protein],
          sodium: options[:sodium],
          water: options[:water],
          meal: options[:meal],
          extras: options[:extra]
        }
      }

      response = post_to_validic('nutrition', options)
      response if response
    end


    def update_nutrition(user_id, nutrition_id, options={})
      options = {
        user_id: user_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        activity_id: nutrition_id,
        nutrition: {
          timestamp: options[:timestamp] || DateTime.now.new_offset(0).iso8601,
          utc_offset: options[:utc_offset],
          calories: options[:calories],
          carbohydrates: options[:carbohydrates],
          fat: options[:fat],
          fiber: options[:fiber],
          protein: options[:protein],
          sodium: options[:sodium],
          water: options[:water],
          meal: options[:meal],
          extras: options[:extra]
        }
      }

      response = put_to_validic('nutrition', options)
      response if response
    end

    def delete_nutrition(user_id, nutrition_id, options={})
      options = {
        user_id: user_id,
        activity_id: nutrition_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id
      }

      response = delete_to_validic('nutrition', options)
      response if response
    end

  end
end
