require 'validic/sleep'

module Validic
  module REST
    module Sleep

      def get_sleep(options = {})
        resp = get_request(:sleep, options)
        build_response_attr(resp)
      end
      alias :get_sleeps :get_sleep

      def create_sleep(user_id, options = {})
        options = { user_id: user_id, sleep: options }
        response = post_request(:sleep, options)
        Validic::Sleep.new(response['sleep'])
      end

      def update_sleep(user_id, activity_id, options = {})
        options = { user_id: user_id, activity_id: activity_id, sleep: options }
        response = put_request(:sleep, options)
        Validic::Sleep.new(response['sleep'])
      end

      def latest_sleep(options = {})
        resp = latest(:sleep, options)
        build_response_attr(resp)
      end

      def delete_sleep(user_id, activity_id, options = {})
        options = { user_id: user_id, activity_id: activity_id }
        delete_request(:sleep, options)
        true
      end
    end
  end
end
