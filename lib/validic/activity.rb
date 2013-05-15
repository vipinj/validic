# encoding: utf-8

module Validic
  module Activity

    ##
    # Get Activity base on `access_token`
    # 
    # @return [Hashie::Mash] with list of Activity
    def get_activities(options={})
      response = get("/#{Validic.api_version}/fitness.json", options)
      response if response
    end

  end
end
