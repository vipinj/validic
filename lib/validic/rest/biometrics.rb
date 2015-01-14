require 'validic/biometrics'
require 'validic/response'

module Validic
  module REST
    module Biometrics

      def get_biometrics(options = {})
        resp = get_request(:biometrics, options)
        build_response_attr(resp)
      end

      def create_biometrics(user_id, options = {})
        options = { user_id: user_id, biometrics: options }
        response = post_request(:biometrics, options)
        Validic::Biometrics.new(response['biometrics'])
      end

      def update_biometrics(user_id, activity_id, options = {})
        options = { user_id: user_id, activity_id: activity_id, biometrics: options }
        response = put_request(:biometrics, options)
        Validic::Biometrics.new(response['biometrics'])
      end

      def delete_biometrics(user_id, activity_id)
        options = { user_id: user_id, activity_id: activity_id }
        delete_request(:biometrics, options)
        true
      end

      def latest_biometrics(options = {})
        resp = latest(:biometrics, options)
        build_response_attr(resp)
      end
    end
  end
end
