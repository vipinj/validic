# encoding: utf-8

module Validic
  module Sleep

    ##
    # Get Sleep Activities base on `access_token`
    # 
    # @return [Hashie::Mash] with list of Sleep
    def get_sleeps(options={})
      organization_id = options[:organization_id]
      options = {
        start_date: options[:start_date],
        end_date: options[:end_date],
        access_token: options[:access_token]
      }

      if options[:access_token] && organization_id
        response = get("/#{Validic.api_version}/organizations/#{organization_id}/sleep.json", options)
      else
        response = get("/#{Validic.api_version}/sleep.json", options)
      end
      response if response
    end

    ##
    # Create Sleep base on `access_token`
    # 
    # @return success
    def create_sleep(options={})
      options = {
        access_token: options[:access_token],
        sleep: {
          total_sleep: options[:total_sleep],
          awake: options[:awake],
          deep: options[:deep],
          light: options[:light],
          rem: options[:rem],
          times_woken: options[:times_woken],
          timestamp: options[:timestamp],
          source: options[:source]
        }
      }

      response = post("/#{Validic.api_version}/sleep.json", options)
      response if response
    end

  end
end
