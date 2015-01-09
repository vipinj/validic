# encoding: utf-8

module Validic
  module Biometric

    ##
    # Get GeneralMeasurement Activities base on `access_token`
    # Default data fetched is from yesterday
    #
    # @params :org_id - for organization specific
    # @params :user_id - for user specific
    #
    # @params :start_date - optional
    # @params :end_date - optional
    # @params :access_token - override for default access_token
    # @params :source - optional - data per source (e.g 'fitbit')
    # @params :expanded - optional - will show the raw data
    #
    # @return [Hashie::Mash] with list of GeneralMeasurement
    def get_biometrics(params={})
      get_endpoint(:biometrics, params)
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
    def create_biometric(user_id, data_id, options={})
      options = {
        user_id: user_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        biometrics: {
          data_id: data_id,
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
          timestamp: options[:timestamp] || DateTime.now.new_offset(0).iso8601,
          utc_offset: options[:utc_offset],
          extras: options[:extras]
        }
      }

      response = post_to_validic('biometrics', options)
      response if response
    end

    ##
    # Update Biometric measurement based on `access_token` and `authentication_token`
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
    def update_biometric(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        activity_id: activity_id,
        biometrics: {
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
          timestamp: options[:timestamp] || DateTime.now.new_offset(0).iso8601,
          utc_offset: options[:utc_offset],
          extras: options[:extras]
        }
      }

      response = put_to_validic('biometrics', options)
      response if response
    end

    ##
    # Delete Biometric measurement
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @return success
    def delete_biometric(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        activity_id: activity_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id
      }

      response = delete_to_validic('biometrics', options)
      response if response
    end

  end
end
