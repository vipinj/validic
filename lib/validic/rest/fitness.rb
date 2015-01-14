# encoding: utf-8
require 'validic/fitness'
require 'validic/response'
require 'validic/rest/utils'

module Validic
  module REST
    module Fitness
      include Validic::REST::Utils

      def get_fitness(options = {})
        resp = get_request(:fitness, options)
        build_response_attr(resp)
      end
      alias :get_fitnesses :get_fitness

      def create_fitness(user_id, options = {})
        options = { user_id: user_id, fitness: options }
        response = post_request(:fitness, options)
        Validic::Fitness.new(response['fitness'])
      end

      def update_fitness(user_id, activity_id, options = {})
        options = { user_id: user_id, activity_id: activity_id, fitness: options }
        response = put_request(:fitness, options)
        Validic::Fitness.new(response['fitness'])
      end

      def delete_fitness(user_id, activity_id)
        options = { user_id: user_id, activity_id: activity_id }
        delete_request(:fitness, options)
        true
      end

      def latest_fitness(options = {})
        resp = latest(:fitness, options)
        build_response_attr(resp)
      end
    end
  end
end
