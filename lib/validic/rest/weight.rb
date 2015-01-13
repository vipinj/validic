require 'validic/weight'
require 'validic/summary'
require 'validic/rest/utils'
module Validic
  module REST
    module Weight
      include Validic::REST::Utils

      def get_weight(params={})
        resp = get_request(:weight, params)
        build_response_attr(resp)
      end

      alias :get_weights :get_weight

      def create_weight(user_id, options={})
        options = { user_id: user_id, weight: options }
        resp = post_request(:weight, options)

        Validic::Weight.new(resp['weight'])
      end

      def update_weight(user_id, activity_id, options={})
        options = {
          user_id: user_id,
          activity_id: activity_id,
          weight: options
        }

        response = put_request(:weight, options)
        Validic::Weight.new(response["weight"])
      end

      def delete_weight(user_id, activity_id)
        options = {
          user_id: user_id,
          activity_id: activity_id,
        }

        delete_request(:weight, options)
        true
      end

      def latest_weight(options={})
        resp = latest(:weight, options)
        build_response_attr(resp)
      end

    end
  end
end
