module Validic
  module REST
    module Utils
      private

      def build_response_attr(resp)
        summary = Validic::Summary.new(resp.delete("summary"))
        klass = Validic.const_get(resp.keys.first.capitalize)
        sleeps = resp.values.flatten.collect { |obj| klass.new(obj) }
        Validic::Response.new(summary, sleeps)
      end

    end
  end
end
