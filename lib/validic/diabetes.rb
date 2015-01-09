# encoding: utf-8

module Validic
  module Diabetes

    ##
    # Get User Diabetes Activities base on `access_token`
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
    # @return [Hashie::Mash] with list of Diabetes
    def get_diabetes(params={})
      get_endpoint(:diabetes, params)
    end

    ##
    # Create Diabetes base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @params :c_peptide
    # @params :fasting_plasma_glucose_test
    # @params :hba1c
    # @params :insulin
    # @params :oral_glucose_tolerance_test
    # @params :random_plasma_glucose_test
    # @params :triglyceride
    # @params :timestamp
    # @params :source
    #
    # @return success
    def create_diabetes(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        diabetes: {
          activity_id: activity_id,
          timestamp: options[:timestamp] || DateTime.now.new_offset(0).iso8601,
          utc_offset: options[:utc_offset],
          c_peptide: options[:c_peptide],
          fasting_plasma_glucose_test: options[:fasting_plasma_glucose_test],
          hba1c: options[:hba1c],
          insulin: options[:insulin],
          oral_glucose_tolerance_test: options[:oral_glucose_tolerance_test],
          random_plasma_glucose_test: options[:random_plasma_glucose_test],
          triglyceride: options[:triglyceride],
          blood_glucose: options[:blood_glucose],
          extras: options[:extras]
        }
      }

      response = post_to_validic('diabetes', options)
      response if response
    end

    ##
    # Update Diabetes record base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @params :c_peptide
    # @params :fasting_plasma_glucose_test
    # @params :hba1c
    # @params :insulin
    # @params :oral_glucose_tolerance_test
    # @params :random_plasma_glucose_test
    # @params :triglyceride
    # @params :timestamp
    # @params :source
    #
    # @return success
    def update_diabetes(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        activity_id: activity_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        diabetes: {
          timestamp: options[:timestamp] || DateTime.now.new_offset(0).iso8601,
          utc_offset: options[:utc_offset],
          c_peptide: options[:c_peptide],
          fasting_plasma_glucose_test: options[:fasting_plasma_glucose_test],
          hba1c: options[:hba1c],
          insulin: options[:insulin],
          oral_glucose_tolerance_test: options[:oral_glucose_tolerance_test],
          random_plasma_glucose_test: options[:random_plasma_glucose_test],
          triglyceride: options[:triglyceride],
          blood_glucose: options[:blood_glucose],
          extras: options[:extras]
        }
      }

      response = put_to_validic('diabetes', options)
      response if response
    end

    ##
    # Delete Diabetes record
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @return success
    def delete_diabetes(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        activity_id: activity_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id
      }

      response = delete_to_validic('diabetes', options)
      response if response
    end

  end
end
