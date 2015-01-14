require 'validic/user'
require 'validic/rest/utils'

module Validic
  module REST
    module Users
      include Validic::REST::Utils

      def get_users(options = {})
        resp = get_request(:users, options)
        build_response_attr(resp)
      end
      alias :get_user :get_users

      def provision_user(options = {})
        options = { user: options }
        response = post_request(:users, options)
        Validic::User.new(response['user'])
      end

      def update_user(user_id, options = {})
        options = { user_id: user_id, user: options }
        response = put_request(:users, options)
        Validic::User.new(response['user'])
      end

      def delete_user(user_id)
        options = { user_id: user_id }
        delete_request(:users, options)
        true
      end
    end
  end
end
