require 'validic/routines'

module Validic
  module REST
    module Routines

      def get_routines(params = {})
        build_response(get_request('routine/intraday', params))
      end

      def latest_routines(options = {})
        build_response(latest('routine/intraday', options))
      end
    end
  end
end
