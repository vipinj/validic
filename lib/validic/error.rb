module Validic
  class Error < StandardError
    ClientError = Class.new(self)
    ServerError = Class.new(self)

    Unauthorized = Class.new(ClientError)
    NotFound = Class.new(ClientError)
    Forbidden = Class.new(ClientError)
    UnprocessableEntity = Class.new(ClientError)
    Conflict = Class.new(ClientError)
    InternalServerError = Class.new(ServerError)

    ERRORS = {
      401 => Validic::Error::Unauthorized,
      403 => Validic::Error::Forbidden,
      404 => Validic::Error::NotFound,
      409 => Validic::Error::Conflict,
      422 => Validic::Error::UnprocessableEntity,
      500 => Validic::Error::InternalServerError
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
