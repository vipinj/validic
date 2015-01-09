# encoding: utf-8

module Validic
  module Sleep

    ##
    # Get Sleep Activities base on `access_token`
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
    # @return [Hashie::Mash] with list of Sleep
    def get_sleep(params={})
      get_endpoint(:sleep, params)
    end

    alias :get_sleeps :get_sleep

    ##
    # Create Sleep base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @params :total_sleep
    # @params :awake
    # @params :deep
    # @params :light
    # @params :rem
    # @params :times_woken
    # @params :timestamp
    # @params :source
    #
    # @return success
    def create_sleep(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        sleep: {
          activity_id: activity_id,
          timestamp: options[:timestamp] || DateTime.now.new_offset(0).iso8601,
          utc_offset: options[:utc_offset],
          total_sleep: options[:total_sleep],
          awake: options[:awake],
          deep: options[:deep],
          light: options[:light],
          rem: options[:rem],
          times_woken: options[:times_woken],
          extras: options[:extras]
        }
      }

      response = post_to_validic('sleep', options)
      response if response
    end

    ##
    # Update Sleep base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @params :total_sleep
    # @params :awake
    # @params :deep
    # @params :light
    # @params :rem
    # @params :times_woken
    # @params :timestamp
    # @params :source
    #
    # @return success
    def update_sleep(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        activity_id: activity_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        sleep: {
          timestamp: options[:timestamp] || DateTime.now.new_offset(0).iso8601,
          utc_offset: options[:utc_offset],
          total_sleep: options[:total_sleep],
          awake: options[:awake],
          deep: options[:deep],
          light: options[:light],
          rem: options[:rem],
          times_woken: options[:times_woken],
          extras: options[:extras]
        }
      }

      response = put_to_validic('sleep', options)
      response if response
    end

    ##
    # Delete Sleep record
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @return success
    def delete_sleep(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        activity_id: activity_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id
      }

      response = delete_to_validic('sleep', options)
      response if response
    end

  end
end
