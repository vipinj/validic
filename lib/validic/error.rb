module Validic
  class Error < StandardError

    ClientError = Class.new(self)
    NotFound = Class.new(ClientError)

    def initialize
    end
  end
end
