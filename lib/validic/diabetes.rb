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
    def get_diabetes(options={})
      organization_id = options[:organization_id]
      user_id = options[:user_id]
      options = {
        start_date: options[:start_date],
        end_date: options[:end_date],
        access_token: options[:access_token],
        source: options[:source],
        expanded: options[:expanded]
      }

      if organization_id
        response = get("/#{Validic.api_version}/organizations/#{organization_id}/diabetes.json", options)
      elsif user_id
        response = get("/#{Validic.api_version}/users/#{user_id}/diabetes.json", options)
      else
        response = get("/#{Validic.api_version}/diabetes.json", options)
      end
      
      response if response
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
    def create_diabetes(options={})
      options = {
        authentication_token: options[:authentication_token],
        access_token: options[:access_token],
        diabetes: {
          c_peptide: options[:c_peptide],
          fasting_plasma_glucose_test: options[:fasting_plasma_glucose_test],
          hba1c: options[:hba1c],
          insulin: options[:insulin],
          oral_glucose_tolerance_test: options[:oral_glucose_tolerance_test],
          random_plasma_glucose_test: options[:random_plasma_glucose_test],
          triglyceride: options[:triglyceride],
          timestamp: options[:timestamp],
          source: options[:source]
        }
      }

      response = post("/#{Validic.api_version}/diabetes.json", options)
      response if response
    end

  end
end
