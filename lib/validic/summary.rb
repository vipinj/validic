module Validic
  class Summary
    attr_reader :timestamp, :start_date, :end_date, :offset, :message,
      :results, :limit, :previous, :next, :status
    def initialize(sum_hash)
      @timestamp = sum_hash["timestamp"]
      @status = sum_hash["status"]
      @offset = sum_hash["offset"]
      @message = sum_hash["message"]
      @results = sum_hash["results"]
      @start_date = sum_hash["start_date"]
      @end_date = sum_hash["end_date"]
      @limit = sum_hash["limit"]
      @previous = sum_hash["previous"]
      @next = sum_hash["next"]
    end
  end
end
