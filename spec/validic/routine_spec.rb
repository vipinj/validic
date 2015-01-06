# encoding: utf-8
require 'spec_helper'

describe Validic::Routine do

  let(:client) { Validic::Client.new }

  context "#get_routines" do
    before do
      @routine = client.get_routines({})
    end

    it "returns JSON response of Validic::Routine", vcr: true do
      @routine.should_not be_nil
    end

    it "status 200" do
      @routine.summary.status.should == 200
    end

    it "has summary node" do
      @routine.summary.should_not be_nil
    end
  end

  context "#create_routine" do
    it "should create new routine record", vcr: true do
      @new_routine = client.create_routine(ENV['PARTNER_USER_ID'], organization_id: ENV['PARTNER_ORG_ID'], access_token: ENV['PARTNER_ACCESS_TOKEN'], activity_id: 'routine_1337', timestamp: "2015-01-06T16:14:17+00:00")
      @new_routine.should_not be_nil
      @new_routine.routine.timestamp.should eq "2015-01-06T16:14:17+00:00"
      @new_routine.routine.activity_id.should eq 'routine_1337'
      @new_routine.routine.source.should eq "healthy_yet"
    end
  end

  context "#get_routines by organization" do
    before do
      @routine = client.get_routines({organization_id: "51aca5a06dedda916400002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Routine", vcr: true do
      @routine.should_not be_nil
    end

    it "status 200" do
      @routine.summary.status.should == 200
    end

    it "has summary node" do
      @routine.summary.should_not be_nil
    end
  end

  context "#get_routines by user" do
    before do
      @routine = client.get_routines({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::Routine", vcr: true do
      @routine.should_not be_nil
    end

    it "status 200" do
      @routine.summary.status.should == 200
    end

    it "has summary node" do
      @routine.summary.should_not be_nil
    end
  end
end
