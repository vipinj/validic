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

  context "#user_provisioning" do
    it "should create a new user under an organization", vcr: true do
      @new_user = client.user_provision(organization_id: "51aca5a06dedda916400002b",
                                        uid: "123asdfg",
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

  context "#user_suspend" do
    it "should suspend a user", vcr: true do
      @suspend_user = client.user_suspend(organization_id: "51aca5a06dedda916400002b",
                                          user_id: '54ac31ef84626b2faf0000ba',
                                          access_token: ENV['TEST_ORG_TOKEN'],
                                          suspend: 1)
      @suspend_user.message.should eq "The user has been suspended successfully"
    end
  end

  context "#user_delete" do
    it "should delete a user", vcr: true do
      @delete_user = client.user_delete(organization_id: "51aca5a06dedda916400002b",
                                        uid: "123asdfg",
                                        access_token: ENV['TEST_ORG_TOKEN'])
      @delete_user.code.should eq 200
    end
  end

end
