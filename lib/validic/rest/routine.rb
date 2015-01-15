require 'validic/response'
require 'validic/routine'

module Validic
  module REST
    module Routine

      def get_routine(params = {})
        resp = get_request(:routine, params)
        build_response_attr(resp)
      end
      alias :get_routines :get_routine

      def create_routine(user_id, options = {})
        options = { user_id: user_id, routine: options }
        response = post_request(:routine, options)
        Validic::Routine.new(response['routine'])
      end

      def update_routine(user_id, activity_id, options = {})
        options = { user_id: user_id, activity_id: activity_id, routine: options }
        response = put_request(:routine, options)
        Validic::Routine.new(response['routine'])
      end

      def delete_routine(user_id, activity_id, options = {})
        options = { user_id: user_id, activity_id: activity_id }
        delete_request(:routine, options)
        true
      end

      def latest_routine(options = {})
        resp = latest(:routine, options)
        build_response_attr(resp)
      end

    end
  end
end
