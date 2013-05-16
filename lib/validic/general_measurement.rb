# encoding: utf-8

module Validic
  module GeneralMeasurement

    ##
    # Get GeneralMeasurement Activities base on `access_token`
    # 
    # @return [Hashie::Mash] with list of GeneralMeasurement
    def get_general_measurements(options={})
      options = {
        start_date: options[:start_date],
        end_date: options[:end_date]
      }
      response = get("/#{Validic.api_version}/biometrics.json", options)
      response if response
    end

    ##
    # Create GeneralMeasurement base on `access_token`
    # 
    # @return success
    def create_general_measurement(options={})
      options = {
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
