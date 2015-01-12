# encoding: utf-8
require 'multi_json'

module Validic
  module REST
    module Request

      def get(path, options)
        request(:get, path, options)
      end

      def post(path, options)
        request(:post, path, options)
      end

      def put(path, options)
        request(:put, path, options)
      end

      def delete(path, options)
        request(:delete, path, options)
      end

      def request(method, path, options)
        options[:access_token] = options[:access_token].nil? ? Validic.access_token : options[:access_token]
        response = connection.send(method) do |request|
          case method
          when :get, :delete
            request.url(path, options)
          when :post, :put
            request.path = path
            request.body = MultiJson.encode(options) unless options.empty?
          end
        end

        response.body
      end

      ##
      # Pull the latest endpoint
      def latest(type, params={})
        organization_id = params[:organization_id] || Validic.organization_id
        user_id = params[:user_id]

        if user_id
          url = "/#{Validic.api_version}/organizations/#{organization_id}/users/#{user_id}/#{type.to_s}/latest.json"
        else
          url = "/#{Validic.api_version}/organizations/#{organization_id}/#{type.to_s}/latest.json"
        end

        get(url, params)
      end

      ##
      # Generic Pull of Validic Objects
      def get_endpoint(type, params={})
        organization_id = params[:organization_id] || Validic.organization_id
        user_id = params.delete(:user_id)

        if user_id
          url = "/#{Validic.api_version}/organizations/#{organization_id}/users/#{user_id}/#{type.to_s}.json"
        else
          url = "/#{Validic.api_version}/organizations/#{organization_id}/#{type.to_s}.json"
        end

        get(url, params)
      end

      ##
      # Generic POST to Validic
      def post_to_validic(type, params={})
        user_id = params.delete(:user_id)
        organization_id = params.delete(:organization_id)

        if user_id
          url = "/#{Validic.api_version}/organizations/#{organization_id}/users/#{user_id}/#{type.to_s}.json"
        else
          url = "/#{Validic.api_version}/organizations/#{organization_id}/#{type.to_s}.json"
        end

        post(url, params)
      end

      ##
      # Generic PUT to Validic Connect
      def put_to_validic(type, params={})
        user_id = params.delete(:user_id)
        organization_id = params.delete(:organization_id)
        activity_id = params.delete(:activity_id)
        url = "/#{Validic.api_version}/organizations/#{organization_id}/users/#{user_id}/#{type.to_s}/#{activity_id}.json"

        put(url, params)
      end

      ##
      # Generic DELETE to Validic Connect
      def delete_to_validic(type, params={})
        user_id = params.delete(:user_id)
        organization_id = params.delete(:organization_id)
        activity_id = params.delete(:activity_id)
        url = "/#{Validic.api_version}/organizations/#{organization_id}/users/#{user_id}/#{type.to_s}/#{activity_id}.json"

        delete(url, params)
      end

    end
  end
end
