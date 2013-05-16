# encoding: utf-8

module Validic
  module Profile

    ##
    # Get Profile base on `access_token`
    # 
    # @return [Hashie::Mash] with list of Profile
    def get_profile(options={})
      response = get("/#{Validic.api_version}/profile.json", options)
      response if response
    end

    ##
    # Update Profile base on `access_token`
    # 
    # @return success
    # def update_profile(options={})
    #   options = {
    #     profile: {
    #       gender: options[:gender],
    #       location: options[:location],
    #       birth_year: options[:birth_year],
    #       height: options[:height],
    #       weight: options[:weight],
    #       first_name: options[:first_name],
    #       last_name: options[:last_name]
    #     }
    #   }

    #   response = post("/#{Validic.api_version}/profile.json", options)
    #   response if response
    # end

  end
end


