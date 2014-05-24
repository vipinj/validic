# encoding: utf-8
require 'active_support/core_ext'
require 'multi_json'

module Validic
  module Request

    def extract_params(params)
      Validic.organization_id = params.delete(:organization_id) if params[:organization_id]
      Validic.user_id = params.delete(:user_id) if params[:user_id]
      params
    end

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

  end
end
