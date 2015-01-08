# encoding: utf-8
require 'spec_helper'

describe Validic::Sleep do

  let(:client) { Validic::Client.new }

  context "#get_sleeps" do
    before do
      @sleep = client.get_sleeps({})
    end

    it "returns JSON response of Validic::Sleep", vcr: true do
      @sleep.should_not be_nil
    end

    it "status 200" do
      @sleep.summary.status.should == 200
    end

    it "has summary node" do
      @sleep.summary.should_not be_nil
    end
  end

  context "#create_sleep" do
    it "should create new sleep record", vcr: true do
      @new_sleep = client.create_sleep(ENV['PARTNER_USER_ID'], 'sleeps_1337', organization_id: ENV['PARTNER_ORG_ID'], access_token: ENV['PARTNER_ACCESS_TOKEN'], timestamp: "2015-01-06T16:14:17+00:00")
      @new_sleep.should_not be_nil
      @new_sleep.sleep.timestamp.should eq "2015-01-06T16:14:17+00:00"
      @new_sleep.sleep.activity_id.should eq 'sleeps_1337'
      @new_sleep.sleep.source.should eq "healthy_yet"
    end
  end

  context "#get_sleeps by organization" do
    before do
      @sleep = client.get_sleeps({organization_id: "51aca5a06dedda916400002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Sleep", vcr: true do
      @sleep.should_not be_nil
    end

    it "status 200" do
      @sleep.summary.status.should == 200
    end

    it "has summary node" do
      @sleep.summary.should_not be_nil
    end
  end

  context "#get_sleeps by user" do
    before do
      @sleep = client.get_sleeps({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::Sleep", vcr: true do
      @sleep.should_not be_nil
    end

    it "status 200" do
      @sleep.summary.status.should == 200
    end

    it "has summary node" do
      @sleep.summary.should_not be_nil
    end
  end
end
