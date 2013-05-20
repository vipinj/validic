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

    ##
    # POST User info for provisioning base on `access_token`
    # params[:org_id] -- organization_id -- String
    # params[:access_token] -- organization's access_token -- String
    # params[:uid] -- uid for the new user -- String
    # params[:profile][:height] -- info for user -- Integer
    # params[:profile][:weight] -- info for user -- String
    # params[:profile][:location] -- info for user -- String
    # params[:profile][:gender] -- info for user -- String
    # params[:profile][:birth_year] -- info for user -- String
    # @return user object
    def user_provision(options={})
      org_id = options[:org_id]
      options = {
        access_token: options[:access_token],
        user: {
          uid: options[:uid],
          profile: {
            height: options[:height],
            gender: options[:gender],
            location: options[:location],
            weight: options[:weight]
          }
        }
      }
      response = post("/#{Validic.api_version}/organizations/#{org_id}/users.json", options)
      response if response
    end
  end
end
