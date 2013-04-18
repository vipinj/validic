# encoding: utf-8
require 'forwardable'
require 'validic/request'

module Validic
  class Client
    extend Forwardable

    include Request

    attr_reader :api_url, :api_version, :access_token

    ##
    # Create a new Validic::Client object
    #
    # @params options[Hash]
    def initialize(options={})
      @api_url        = options[:api_url]       || Validic.api_url
      @api_version    = options[:api_version]   || Validic.api_version
      @access_token   = options[:access_token]  || Validic.access_token
    end

    ##
    # Create a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      params = {}
      @connection = Faraday.new(url: api_url, params: params, headers: default_headers) do |faraday|
        faraday.use FaradayMiddleware::Mashify
        faraday.use FaradayMiddleware::ParseJson, content_type: /\bjson$/
        faraday.use FaradayMiddleware::FollowRedirects
        faraday.adapter Faraday.default_adapter
      end
    end

    private

    def default_headers
      headers = {
        accept: 'application/json',
        content_type: 'application/json',
        user_agent: "Ruby Gem by Validic #{Validic::VERSION}"
      }
    end

  end
end
