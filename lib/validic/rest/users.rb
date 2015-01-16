require 'validic/user'

module Validic
  module REST
    module Users

      def get_users(options = {})
        resp = get_request(:users, options)
        build_response_attr(resp)
      end
      alias :get_user :get_users

      def refresh_token(options = {})
        response = get_request(:refresh_token, options)
        Validic::User.new(response['user'])
      end

      def me(options = {})
        response = get_request(:me, options)
        response['me']['_id']
      end

      def provision_user(options = {})
        response = post_request(:users, { user: options })
        Validic::User.new(response['user'])
      end

      def update_user(options = {})
        user_id = options.delete(:user_id)
        response = put_request(:users, { user_id: user_id, user: options })
        Validic::User.new(response['user'])
      end

      def delete_user(options = {})
        delete_request(:users, { user_id: options[:user_id] })
        true
      end

      def suspend_user(options = {})
        put_request(:users, { user_id: options[:user_id], suspend: '1' })
        true
      end

      def unsuspend_user(options = {})
        put_request(:users, { user_id: options[:user_id], suspend: '0' })
        true
      end
    end
  end
end
