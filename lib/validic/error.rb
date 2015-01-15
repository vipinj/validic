module Validic
  class Error < StandardError
    ClientError = Class.new(self)
    NotFound = Class.new(ClientError)

    def initialize(message = '')
      super(message)
    end
  end
end
