require 'validic/user'

module Validic
  module REST
    module Users
      def provision_user(options = {})
        options = { user: options }
        response = post_request(:users, options)
        Validic::User.new(response['user'])
      end
    end
  end
end
