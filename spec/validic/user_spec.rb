# encoding: utf-8
require 'spec_helper'

describe Validic::User do

  let(:client) { Validic::Client.new }

  context "#get_users" do
    before do
      @users_response = client.get_users
    end

    it "returns JSON response of Validic::Organization", vcr: true do
      expect(@users_response).not_to be_nil
    end

    it "status 200" do
      expect(@users_response.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@users_response.summary).not_to be_nil
    end

  end

  context "#me" do
    before do
      @me = client.me(ENV['TEST_USER_AUTHENTICATION_TOKEN'])
    end

    it "returns JSON response of Validic::User", vcr: true do
      expect(@me).not_to be_nil
    end

    it "should return the user id" do
      expect(@me.me._id).not_to be_nil
    end
  end

  context "#provision_user" do
    it "should only need a uid parameter", vcr: true do
      @new_user = client.provision_user("acme_101")
      expect(@new_user.user.access_token).not_to be_nil
    end

    it "should create a new user under an organization", vcr: true do
      @new_user = client.provision_user("acme_201",
                                        organization_id: ENV['TEST_ORG_ID'],
                                        height: 167.0,
                                        weight: 69.0,
                                        location: "TX",
                                        gender: "M")
      expect(@new_user.user.access_token).not_to be_nil
      expect(@new_user.user.profile.height).to eq 167.0
      expect(@new_user.user.profile.weight).to eq 69.0
      expect(@new_user.user.profile.location).to eq 'TX'
      expect(@new_user.user.profile.gender).to eq 'M'
    end
  end

  context "#update_user" do
    it "should update a user", vcr: true do
      @update_user = client.update_user("54aeb53784626b2ead000245",
                                        uid: "updated_uid",
                                        gender: "M",
                                        location: "TX",
                                        country: "USA",
                                        birth_year: 1987,
                                        height: 72.0,
                                        weight: 200.0)

      expect(@update_user.code).to eq 200
    end
  end

  context "#suspend_user" do
    it "should only need a user id parameter", vcr: true do
      @suspend_user = client.suspend_user("54aeb53784626b2ead000245")
      expect(@suspend_user.message).to eq "The user has been suspended successfully"
    end

    it "should suspend a user", vcr: true do
      @suspend_user = client.suspend_user("54aeb5b484626b4e66000228",
                                          organization_id: ENV['TEST_ORG_ID'],
                                          access_token: ENV['TEST_ORG_TOKEN'])
      expect(@suspend_user.message).to eq "The user has been suspended successfully"
    end
  end

  context "#unsuspend_user" do
    it "should only need a user id parameter", vcr: true do
      @unsuspend_user = client.unsuspend_user("54aeb53784626b2ead000245")
      expect(@unsuspend_user.message).to eq "The user has been unsuspended successfully"
    end

    it "should unsuspend a user", vcr: true do
      @unsuspend_user = client.unsuspend_user("54aeb5b484626b4e66000228",
                                          organization_id: ENV['TEST_ORG_ID'],
                                          access_token: ENV['TEST_ORG_TOKEN'])
      expect(@unsuspend_user.message).to eq "The user has been unsuspended successfully"
    end
  end

  context "#refresh_token" do
    it "should only need a user id parameter", vcr: true do
      @refresh_token = client.refresh_token("54aeb53784626b2ead000245")
      expect(@refresh_token.code).to eq 200
      expect(@refresh_token.user.authentication_token).not_to be_nil
    end

    it "should work with organization id and access token options", vcr: true do
      @refresh_token = client.refresh_token("54aeb5b484626b4e66000228",
                                            organization_id: ENV['TEST_ORG_ID'],
                                            access_token: ENV['TEST_ORG_TOKEN'])
      expect(@refresh_token.code).to eq 200
      expect(@refresh_token.user.authentication_token).not_to be_nil
    end
  end

  context "#delete_user" do
    it "should only need a user id parameter", vcr: true do
      @delete_user = client.delete_user("54aeb53784626b2ead000245")
      expect(@delete_user.code).to eq 200
    end

    it "should delete a user by user id", vcr: true do
      @delete_user = client.delete_user("54aeb5b484626b4e66000228",
                                        organization_id: ENV['TEST_ORG_ID'],
                                        access_token: ENV['TEST_ORG_TOKEN'])
      expect(@delete_user.code).to eq 200
    end
  end

end
