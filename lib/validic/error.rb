module Validic
  class Error < StandardError
    ClientError = Class.new(self)

    NotFound = Class.new(ClientError)
    Forbidden = Class.new(ClientError)
    UnprocessableEntity = Class.new(ClientError)

    ERRORS = {
      403 => Validic::Error::Forbidden,
      404 => Validic::Error::NotFound,
      422 => Validic::Error::UnprocessableEntity
    }

    def self.from_response(body)
      code, errors = [body['code'], body['errors']]
      message = "#{code}: #{errors}"
      new(message)
    end

    def initialize(message = '', code = nil)
      super(message)
      @code = code
    end
  end
end
