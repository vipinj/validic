# encoding: utf-8

module Validic
  module Diabetes

    ##
    # Get User Diabetes Activities base on `access_token`
    # 
    # @return [Hashie::Mash] with list of Diabetes
    def get_diabetes(options={})
      org_id = options[:org_id]
      options = {
        start_date: options[:start_date],
        end_date: options[:end_date],
        access_token: options[:access_token]
      }

      if options[:access_token] && org_id
        response = get("/#{Validic.api_version}/organizations/#{org_id}/diabetes.json", options)
      else
        response = get("/#{Validic.api_version}/diabetes.json", options)
      end
      
      response if response
    end

    ##
    # Create Diabetes base on `access_token`
    # 
    # @return success
    def create_diabetes(options={})
      options = {
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
