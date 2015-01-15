require 'validic/profile'

module Validic
  module REST
    module Profile
      def get_profile(user_authentication_token)
        resp = get_request(:profile, authentication_token: user_authentication_token)

        Validic::Profile.new(resp)
      end

      def create_profile(user_authentication_token, options = {})
        options = { authentication_token: user_authentication_token,
                    profile: options
        }
        resp = post_request(:profile, options)

        Validic::Profile.new(resp['profile'])
      end
    end
  end
end
