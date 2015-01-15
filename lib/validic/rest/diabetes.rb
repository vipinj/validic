require 'validic/diabetes'

module Validic
  module REST
    module Diabetes

      def get_diabetes(options = {})
        resp = get_request(:diabetes, options)
        build_response_attr(resp)
      end

      def create_diabetes(user_id, options = {})
        options = { user_id: user_id, diabetes: options }
        response = post_request(:diabetes, options)
        Validic::Diabetes.new(response['diabetes'])
      end

      def update_diabetes(user_id, activity_id, options = {})
        options = { user_id: user_id, activity_id: activity_id, diabetes: options }
        response = put_request(:diabetes, options)
        Validic::Diabetes.new(response['diabetes'])
      end

      def delete_diabetes(user_id, activity_id)
        options = { user_id: user_id, activity_id: activity_id }
        delete_request(:diabetes, options)
        true
      end

      def latest_diabetes(options = {})
        resp = latest(:diabetes, options)
        build_response_attr(resp)
      end
    end
  end
end
