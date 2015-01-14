module Validic
  class Response
    attr_reader :summary, :records
    def initialize(summary, record_array)
      @summary = summary
      @records = record_array
    end
  end
end
