# encoding: utf-8
require 'spec_helper'

describe Validic::TobaccoCessation do

  let(:client) { Validic::Client.new }

  context "#get_tobacco_cessation" do
    before do
      @tobacco_cessation = client.get_tobacco_cessations({})
    end

    it "returns JSON response of Validic::TobaccoCessation", vcr: true do
      @tobacco_cessation.should_not be_nil
    end

    it "status 200" do
      @tobacco_cessation.summary.status.should == 200 
    end

    it "has summary node" do
      @tobacco_cessation.summary.should_not be_nil
    end
  end

  context "#create_tobacco_cessation" do
    it "should create new tobacco_cessation record" do
      @new_tobacco_cessation = client.create_tobacco_cessation({authentication_token: "mqwpDx8RYcmSFBJDmy3J",
                                                                access_token: "DEMO_KEY",
                                                                timestamp: "2013-05-01 07:12:16 -05:00",
                                                                cigarettes_allowed: 10,
                                                                cigarettes_smoked: 11,
                                                                cravings: 15,
                                                                last_smoked: "2013-05-16 07:12:16 -05:00",
                                                                source: "Sample App"})
      @new_tobacco_cessation.should_not be_nil
      @new_tobacco_cessation.tobacco_cessation.timestamp.should eq "2013-05-01 07:12:16 -05:00"
      @new_tobacco_cessation.tobacco_cessation.cigarettes_allowed.should eq 10.0
      @new_tobacco_cessation.tobacco_cessation.cigarettes_smoked.should eq 11.0
      @new_tobacco_cessation.tobacco_cessation.cravings.should eq 15.0
      @new_tobacco_cessation.tobacco_cessation.last_smoked.should eq "2013-05-16 07:12:16 -05:00"
    end
  end

  context "#get_tobacco_cessations by organization" do
    before do
      @tobacco_cessation = client.get_tobacco_cessations({organization_id: "519e24e16a7e0cc7ef00002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::TobaccoCessation", vcr: true do
      @tobacco_cessation.should_not be_nil
    end

    it "status 200" do
      @tobacco_cessation.summary.status.should == 200 
    end

    it "has summary node" do
      @tobacco_cessation.summary.should_not be_nil
    end
  end

  context "#get_tobacco_cessations by user" do
    before do
      @tobacco_cessation = client.get_tobacco_cessations({user_id: "519e24e16a7e0cc7ef00002c"})
    end

    it "returns JSON response of Validic::TobaccoCessation", vcr: true do
      @tobacco_cessation.should_not be_nil
    end

    it "status 200" do
      @tobacco_cessation.summary.status.should == 200 
    end

    it "has summary node" do
      @tobacco_cessation.summary.should_not be_nil
    end
  end
end
