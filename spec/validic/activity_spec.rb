# encoding: utf-8
require 'spec_helper'

describe Validic::Activity do

  let(:client) { Validic::Client.new }

  context "#get_activities" do
    before do
      @activities_response = client.get_activities({})
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
      @activities_response = client.get_activities({organization_id: "519e24e16a7e0cc7ef00002b", access_token: "ENTERPRISE_KEY"})
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
      @activities_response = client.get_activities({user_id: "519e24e16a7e0cc7ef00002c"})
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

end
