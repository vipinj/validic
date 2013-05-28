# encoding: utf-8
require 'spec_helper'

describe Validic::User do

  let(:client) { Validic::Client.new }

  context "#me" do
    before do
      @me = client.me({})
    end

    it "returns JSON response of Validic::User", vcr: true do
      @me.should_not be_nil
    end

    it "should return the user id" do
      @me.user._id.should_not be_nil
    end
  end

  context "#user_provisioning" do
    it "should create a new user under an organization" do
      @new_user = client.user_provision({organization_id: "51964ba56a7e0c2417000029",
                                         access_token: "ENTERPRISE_KEY",
                                         uid: "123asdfg",
                                         height: 167,
                                         weight: 69,
                                         location: "TX",
                                         gender: "M"})
      @new_user.users.access_token.should_not be_nil
      @new_user.users.profile.height.should eq "167"
      @new_user.users.profile.weight.should eq 69
      @new_user.users.profile.location.should eq 'TX'
      @new_user.users.profile.gender.should eq 'M'
    end
  end

end
