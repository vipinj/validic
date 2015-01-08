# encoding: utf-8
require 'spec_helper'

describe Validic::User do

  let(:client) { Validic::Client.new }

  context "#get_users" do
    before do
      @users_response = client.get_users
    end

    it "returns JSON response of Validic::Organization", vcr: true do
      @users_response.should_not be_nil
    end

    it "status 200" do
      @users_response.summary.status.should == 200
    end

    it "has summary node" do
      @users_response.summary.should_not be_nil
    end

  end

  context "#me" do
    before do
      @me = client.me(ENV['TEST_USER_AUTHENTICATION_TOKEN'])
    end

    it "returns JSON response of Validic::User", vcr: true do
      @me.should_not be_nil
    end

    it "should return the user id" do
      @me.me._id.should_not be_nil
    end
  end

  context "#provision_user" do
    it "should only need a uid parameter", vcr: true do
      @new_user = client.provision_user("acme_101")
      @new_user.user.access_token.should_not be_nil
    end

    it "should create a new user under an organization", vcr: true do
      @new_user = client.provision_user("acme_201",
                                        organization_id: ENV['TEST_ORG_ID'],
                                        height: 167.0,
                                        weight: 69.0,
                                        location: "TX",
                                        gender: "M")
      @new_user.user.access_token.should_not be_nil
      @new_user.user.profile.height.should eq 167.0
      @new_user.user.profile.weight.should eq 69.0
      @new_user.user.profile.location.should eq 'TX'
      @new_user.user.profile.gender.should eq 'M'
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

      @update_user.code.should eq 200
    end
  end

  context "#suspend_user" do
    it "should only need a user id parameter", vcr: true do
      @suspend_user = client.suspend_user("54aeb53784626b2ead000245")
      @suspend_user.message.should eq "The user has been suspended successfully"
    end

    it "should suspend a user", vcr: true do
      @suspend_user = client.suspend_user("54aeb5b484626b4e66000228",
                                          organization_id: ENV['TEST_ORG_ID'],
                                          access_token: ENV['TEST_ORG_TOKEN'])
      @suspend_user.message.should eq "The user has been suspended successfully"
    end
  end

  context "#unsuspend_user" do
    it "should only need a user id parameter", vcr: true do
      @unsuspend_user = client.unsuspend_user("54aeb53784626b2ead000245")
      @unsuspend_user.message.should eq "The user has been unsuspended successfully"
    end

    it "should unsuspend a user", vcr: true do
      @unsuspend_user = client.unsuspend_user("54aeb5b484626b4e66000228",
                                          organization_id: ENV['TEST_ORG_ID'],
                                          access_token: ENV['TEST_ORG_TOKEN'])
      @unsuspend_user.message.should eq "The user has been unsuspended successfully"
    end
  end

  context "#refresh_token" do
    it "should only need a user id parameter", vcr: true do
      @refresh_token = client.refresh_token("54aeb53784626b2ead000245")
      @refresh_token.code.should eq 200
      @refresh_token.user.authentication_token.should_not be_nil
    end

    it "should work with organization id and access token options", vcr: true do
      @refresh_token = client.refresh_token("54aeb5b484626b4e66000228",
                                            organization_id: ENV['TEST_ORG_ID'],
                                            access_token: ENV['TEST_ORG_TOKEN'])
      @refresh_token.code.should eq 200
      @refresh_token.user.authentication_token.should_not be_nil
    end
  end

  context "#delete_user" do
    it "should only need a user id parameter", vcr: true do
      @delete_user = client.delete_user("54aeb53784626b2ead000245")
      @delete_user.code.should eq 200
    end

    it "should delete a user by user id", vcr: true do
      @delete_user = client.delete_user("54aeb5b484626b4e66000228",
                                        organization_id: ENV['TEST_ORG_ID'],
                                        access_token: ENV['TEST_ORG_TOKEN'])
      @delete_user.code.should eq 200
    end
  end

end
