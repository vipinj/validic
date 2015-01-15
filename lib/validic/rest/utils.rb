module Validic
  module REST
    module Utils
      private

      def build_response_attr(resp)
        summary = Validic::Summary.new(resp.delete("summary"))
        klass = Validic.const_get(camelize_response_key(resp))
        records = resp.values.flatten.collect { |obj| klass.new(obj) }
        Validic::Response.new(summary, records)
      end

      def camelize_response_key(resp)
        key = resp.keys.first
        key = key.include?('_') ? key.split('_').map(&:capitalize).join : key.capitalize
        key.chop! if %w(Users Apps).include?(key) #strip last letter off to match ::User or ::App
        key
      end
    end
  end
end
