# encoding: utf-8

module Validic
  module Activity

    ##
    # Get Activity base on `access_token`
    # 
    # @return [Hashie::Mash] with list of Activity
    def get_activities(options={})
      org_id = options[:org_id]
      options = {
        access_token: options[:access_token],
        start_date: options[:start_date],
        end_date: options[:end_date]
      }

      if options[:access_token] && org_id
        response = get("/#{Validic.api_version}/organizations/#{org_id}/fitness.json", options)
      else
        response = get("/#{Validic.api_version}/fitness.json", options)
      end
      
      response if response
    end

  end
end
