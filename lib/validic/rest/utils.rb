module Validic
  module REST
    module Utils
      private

      def build_response_attr(resp)
        summary = Validic::Summary.new(resp.delete("summary"))
        klass = Validic.const_get(camelize_response_key(resp))
        sleeps = resp.values.flatten.collect { |obj| klass.new(obj) }
        Validic::Response.new(summary, sleeps)
      end

      def camelize_response_key(resp)
        key = resp.keys.first
        key.include?('_') ? key.split('_').map(&:capitalize).join : key.capitalize
      end
    end
  end
end
