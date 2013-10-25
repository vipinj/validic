# encoding: utf-8

module Validic
  module Biometric

    ##
    # Get GeneralMeasurement Activities base on `access_token`
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
    # @return [Hashie::Mash] with list of GeneralMeasurement
    def get_biometrics(options={})
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
        response = get("/#{Validic.api_version}/organizations/#{organization_id}/biometrics.json", options)
      elsif user_id
        response = get("/#{Validic.api_version}/users/#{user_id}/biometrics.json", options)
      else
        response = get("/#{Validic.api_version}/biometrics.json", options)
      end
      response if response
    end

    ##
    # Create GeneralMeasurement base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @params :blood_calcium
    # @params :blood_chromium
    # @params :blood_folic_acid
    # @params :blood_magnesium
    # @params :blood_potassium
    # @params :blood_sodium
    # @params :blood_vitamin_b12
    # @params :blood_zinc
    # @params :creatine_kinase
    # @params :crp
    # @params :diastolic
    # @params :ferritin
    # @params :hdl
    # @params :hscrp
    # @params :il6
    # @params :ldl
    # @params :resting_heartrate
    # @params :systolic
    # @params :testosterone
    # @params :total_cholesterol
    # @params :tsh
    # @params :uric_acid
    # @params :vitamin_d
    # @params :white_cell_count
    # @params :timestamp
    # @params :source
    # 
    # @return success
    def create_biometric(options={})
      options = {
        access_token: options[:access_token],
        general_measurement: {
          blood_calcium: options[:blood_calcium],
          blood_chromium: options[:blood_chromium],
          blood_folic_acid: options[:blood_folic_acid],
          blood_magnesium: options[:blood_magnesium],
          blood_potassium: options[:blood_potassium],
          blood_sodium: options[:blood_sodium],
          blood_vitamin_b12: options[:blood_vitamin_b12],
          blood_zinc: options[:blood_zinc],
          creatine_kinase: options[:creatine_kinase],
          crp: options[:crp],
          diastolic: options[:diastolic],
          ferritin: options[:ferritin],
          hdl: options[:hdl],
          hscrp: options[:hscrp],
          il6: options[:il6],
          ldl: options[:ldl],
          resting_heartrate: options[:resting_heartrate],
          systolic: options[:systolic],
          testosterone: options[:testosterone],
          total_cholesterol: options[:total_cholesterol],
          tsh: options[:tsh],
          uric_acid: options[:uric_acid],
          vitamin_d: options[:vitamin_d],
          white_cell_count: options[:white_cell_count],
          timestamp: options[:timestamp],
          source: options[:source]
        }
      }

      response = post("/#{Validic.api_version}/biometrics.json", options)
      response if response
    end

  end
end
