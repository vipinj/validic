# encoding: utf-8

module Validic
  module User

    ##
    # Get User id base on `access_token`
    # 
    # @return id
    def me(options={})
      response = get("/#{Validic.api_version}/me.json", options)
      response if response
    end

  end
end

