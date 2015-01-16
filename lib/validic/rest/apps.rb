require 'validic/app'

module Validic
  module REST
    module Apps

      def get_org_apps
        resp = get_request(:apps)
        build_response_attr(resp)
      end

      def get_user_synced_apps(options = {})
        resp = get_request(:sync_apps,
                           authentication_token: options[:authentication_token])
        build_response_attr(resp)
      end
    end
  end
end
