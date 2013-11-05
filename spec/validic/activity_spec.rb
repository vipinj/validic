# encoding: utf-8
require 'spec_helper'

describe Validic::Activity do

  let(:client) { Validic::Client.new }

  context "#get_activities" do
    before do
      @activities_response = client.get_activities({ activity_type: "routine" })
    end

    it "returns JSON response of Validic::Activity", vcr: true do
      @activities_response.should_not be_nil
    end

    it "status 200" do
      @activities_response.summary.status.should == 200 
    end

    it "has summary node" do
      @activities_response.summary.should_not be_nil
    end
  end

  context "#get_activities via organization" do
    before do
      @activities_response = client.get_activities({organization_id: "519e24e16a7e0cc7ef00002b", activity_type: "routine", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Activity", vcr: true do
      @activities_response.should_not be_nil
    end

    it "status 200" do
      @activities_response.summary.status.should == 200 
    end

    it "has summary node" do
      @activities_response.summary.should_not be_nil
    end
  end

  context "#get_activities of a user" do
    before do
      @activities_response = client.get_activities({user_id: "519e24e16a7e0cc7ef00002c", activity_type: "routine"})
    end

    it "returns JSON response of Validic::Activity", vcr: true do
      @activities_response.should_not be_nil
    end

    it "status 200" do
      @activities_response.summary.status.should == 200 
    end

    it "has summary node" do
      @activities_response.summary.should_not be_nil
    end
  end

  context "#get_latest_activities of a user base on activity_type" do
    before do
      @latest_activities_response = client.get_latest_activities(user_id: "519e24e16a7e0cc7ef00002c", access_token: "9c03ad2bcb022425944e4686d398ef8398f537c2f7c113495ffa7bc9cfa49286", activity_type: "routine")
    end

    it "returns JSON response of Validic::Activity", vcr: true do
      @latest_activities_response.should_not be_nil
    end

    it "status 200" do
      @latest_activities_response.summary.status.should == 200
    end

    it "has summary node" do
      @latest_activities_response.summary.should_not be_nil
    end
  end

  context "#get_latest_activities of an organization base on activity_type" do
    before do
      @latest_activities_response = client.get_latest_activities(organization_id: "519e24e16a7e0cc7ef00002b", activity_type: "routine", access_token: "296a9c1d73c1b40af4c8e643336cb25524caf2a7679ba92c192855160572fdb1")
    end

    it "returns JSON response of Validic::Activity", vcr: true do
      @latest_activities_response.should_not be_nil
    end

    it "status 200" do
      @latest_activities_response.summary.status.should == 200
    end

    it "has summary node" do
      @latest_activities_response.summary.should_not be_nil
    end
  end
end
