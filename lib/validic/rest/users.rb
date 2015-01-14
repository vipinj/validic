require 'validic/user'
require 'validic/rest/utils'

module Validic
  module REST
    module Users

      def get_users(options = {})
        resp = get_request(:users, options)
        build_response_attr(resp)
      end
      alias :get_user :get_users

      def provision_user(options = {})
        response = post_request(:users, { user: options })
        Validic::User.new(response['user'])
      end

      def update_user(user_id, options = {})
        response = put_request(:users, { user_id: user_id, user: options })
        Validic::User.new(response['user'])
      end

      def delete_user(user_id)
        delete_request(:users, { user_id: user_id })
        true
      end

      def me(auth_token)
        response = get_request(:me, authentication_token: auth_token)
        response['me']['_id']
      end

      def suspend_user(user_id)
        put_request(:users, { user_id: user_id, suspend: '1' })
        true
      end

      def unsuspend_user(user_id)
        put_request(:users, { user_id: user_id, suspend: '0' })
        true
      end

      def refresh_token(user_id)
        response = get_request(:refresh_token, { user_id: user_id })
        Validic::User.new(response['user'])
      end
    end
  end
end
