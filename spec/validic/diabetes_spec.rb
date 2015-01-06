# encoding: utf-8
require 'spec_helper'

describe Validic::Diabetes do

  let(:client) { Validic::Client.new }

  context "#get_diabetes" do
    before do
      @user_diabetes = client.get_diabetes({})
    end

    it "returns JSON response of Validic::Diabetes", vcr: true do
      @user_diabetes.should_not be_nil
    end

    it "status 200" do
      @user_diabetes.summary.status.should == 200
    end

    it "has summary node" do
      @user_diabetes.summary.should_not be_nil
    end
  end

  context "#create_diabetes" do
    it "should create new diabetes record", vcr: true do
      @new_diabetes = client.create_diabetes(ENV['PARTNER_USER_ID'], organization_id: ENV['PARTNER_ORG_ID'], access_token: ENV['PARTNER_ACCESS_TOKEN'], activity_id: 'diabetes_1', timestamp: "2015-01-06T16:14:17+00:00")
      @new_diabetes.should_not be_nil
      @new_diabetes.diabetes.timestamp.should eq "2015-01-06T16:14:17+00:00"
      @new_diabetes.diabetes.activity_id.should eq 'diabetes_1'
      @new_diabetes.diabetes.source.should eq "healthy_yet"
    end
  end

  context "#get_diabetes by organization" do
    before do
      @org_diabetes = client.get_diabetes({organization_id: "51aca5a06dedda916400002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Diabetes", vcr: true do
      @org_diabetes.should_not be_nil
    end

    it "status 200" do
      @org_diabetes.summary.status.should == 200
    end

    it "has summary node" do
      @org_diabetes.summary.should_not be_nil
    end
  end

  context "#get_diabetes by user" do
    before do
      @user_diabetes = client.get_diabetes({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::Diabetes", vcr: true do
      @user_diabetes.should_not be_nil
    end

    it "status 200" do
      @user_diabetes.summary.status.should == 200
    end

    it "has summary node" do
      @user_diabetes.summary.should_not be_nil
    end
  end

end
