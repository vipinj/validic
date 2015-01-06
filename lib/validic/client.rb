# encoding: utf-8
require 'forwardable'
require 'validic/request'
require 'validic/organization'
require 'validic/user'
require 'validic/profile'
require 'validic/fitness'
require 'validic/weight'
require 'validic/nutrition'
require 'validic/sleep'
require 'validic/diabetes'
require 'validic/biometric'
require 'validic/routine'
require 'validic/tobacco_cessation'
require 'validic/third_party_app'

module Validic
  class Client
    extend Forwardable

    include Request
    include Organization
    include User
    include Profile
    include Fitness
    include Weight
    include Nutrition
    include Sleep
    include Diabetes
    include Biometric
    include Routine
    include TobaccoCessation
    include ThirdPartyApp

    attr_accessor :api_url,
      :api_version,
      :access_token,
      :organization_id

    ##
    # Create a new Validic::Client object
    #
    # @params options[Hash]
    def initialize(options={})
      @api_url        = options[:api_url].nil? ? Validic.api_url : options[:api_url]
      @api_version    = options[:api_version].nil? ? 'v1' : options[:api_version]
      @access_token   = options[:access_token].nil? ? Validic.access_token : options[:access_token]
      @organization_id = options[:organization_id].nil? ? Validic.organization_id : options[:organization_id]

      reload_config
    end

    ##
    # Create a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      params = {}
      @connection = Faraday.new(url: @api_url, params: params, headers: default_headers, ssl: {verify: true}) do |faraday|
        faraday.use FaradayMiddleware::Mashify
        faraday.use FaradayMiddleware::ParseJson, content_type: /\bjson$/
        faraday.use FaradayMiddleware::FollowRedirects
        faraday.adapter Faraday.default_adapter
      end
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

      if params[:user_id] && type != :users
        url = "/#{Validic.api_version}/organizations/#{organization_id}/users/#{params[:user_id]}/#{type.to_s}.json"
      elsif params[:user_id] && type == :users
        url = "/#{Validic.api_version}/organizations/#{organization_id}/users/#{params[:user_id]}.json"
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

    private

    def default_headers
      {
        accept: 'application/json',
        content_type: 'application/json',
        user_agent: "Ruby Gem by Validic #{Validic::VERSION}"
      }
    end

    def reload_config
      Validic.api_url = api_url
      Validic.api_version = api_version
      Validic.access_token = access_token
      Validic.organization_id = organization_id
    end

  end
end
