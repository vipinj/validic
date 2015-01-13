# encoding: utf-8
require 'validic/sleep'
require 'validic/summary'
require 'validic/response'
module Validic
  module REST
    module Sleep
      def get_sleep(params={})
        resp = get_request(:sleep, params)
        build_response_attr(resp)
      end
      alias :get_sleeps :get_sleep

      def create_sleep(user_id, options={})
        options = { user_id: user_id, sleep: options }
        response = post_request(:sleep, options)
        Validic::Sleep.new(response['sleep'])
      end

      def update_sleep(user_id, activity_id, options={})
        options = {
          user_id: user_id,
          activity_id: activity_id,
          sleep: options
        }
        response = put_request(:sleep, options)
        Validic::Sleep.new(response['sleep'])
      end

      def latest_sleep(options={})
        resp = latest(:sleep, options)
        build_response_attr(resp)
      end

      def delete_sleep(user_id, activity_id, options={})
        options = {
          user_id: user_id,
          activity_id: activity_id,
          organization_id: options[:organization_id] || Validic.organization_id
        }
        delete_request(:sleep, options)
        true
      end

      private

      def build_response_attr(resp)
        summary = Validic::Summary.new(resp["summary"])
        sleeps = resp["sleep"].collect { |sleep| Validic::Sleep.new(sleep) }
        Validic::Response.new(summary, sleeps)
      end
    end
  end
end
