# encoding: utf-8
require 'validic/tobacco_cessation'
require 'validic/response'
require 'validic/rest/utils'

module Validic
  module REST
    module TobaccoCessation
      include Validic::REST::Utils

      def get_tobacco_cessation(options = {})
        resp = get_request(:tobacco_cessation, options)
        build_response_attr(resp)
      end
      alias :get_tobacco_cessations :get_tobacco_cessation

      def create_tobacco_cessation(user_id, options = {})
        options = { user_id: user_id, tobacco_cessation: options }
        response = post_request(:tobacco_cessation, options)
        Validic::TobaccoCessation.new(response['tobacco_cessation'])
      end

      def update_tobacco_cessation(user_id, activity_id, options = {})
        options = { user_id: user_id, activity_id: activity_id, tobacco_cessation: options }
        response = put_request(:tobacco_cessation, options)
        Validic::TobaccoCessation.new(response['tobacco_cessation'])
      end

      def delete_tobacco_cessation(user_id, activity_id)
        options = { user_id: user_id, activity_id: activity_id }
        delete_request(:tobacco_cessation, options)
        true
      end

      def latest_tobacco_cessation(options = {})
        resp = latest(:tobacco_cessation, options)
        build_response_attr(resp)
      end
    end
  end
end
