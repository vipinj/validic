# encoding: utf-8

module Validic
  module Profile

    ##
    # Get Profile base on `access_token`
    #
    # @params :access_token - override for default access_token
    # @return [Hashie::Mash] with list of Profile
    def get_profile(authentication_token)
      options = { authentication_token: authentication_token }
      response = get("/#{Validic.api_version}/profile.json", options)
      response if response
    end

    ##
    # Create Profile based on `authentication_token`
    #
    # @return success
    def create_profile(authentication_token, options={})
      options = {
        authentication_token: authentication_token,
        profile: {
          gender: options[:gender],
          location: options[:location],
          country: options[:country],
          birth_year: options[:birth_year],
          height: options[:height],
          weight: options[:weight]
        }
      }

      response = post("/#{Validic.api_version}/profile.json", options)
      response if response
    end

  end
end


