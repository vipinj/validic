module Validic
  class Response
    attr_reader :summary, :records, :attributes
    def initialize(summary, response)
      @summary = summary

      case response
      when Array
        @records = response
      when Hash
        @attributes = response
      end
    end
  end
end
