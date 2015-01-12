module Validic
  class Response
    attr_reader :summary, :sleeps
    def initialize(summary, record_array)
      @summary = summary
      @sleeps = record_array
    end

  end
end
