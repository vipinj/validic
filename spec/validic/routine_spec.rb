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

  context "Validic Connect" do
    before do
      @connect = Validic::Client.new(organization_id: ENV['PARTNER_ORG_ID'],
                                     access_token: ENV['PARTNER_ACCESS_TOKEN'],
                                     api_url: 'https://api.validic.com',
                                     api_version: 'v1')
    end

    context "#create_routine" do
      it "should create new routine record", vcr: true do
        @new_routine = @connect.create_routine(ENV['PARTNER_USER_ID'], "routinez")
        @new_routine.should_not be_nil
        @new_routine.routine.activity_id.should eq "routinez"
        @new_routine.routine.source.should eq "healthy_yet"
      end
    end

    context "#update_routine" do
      it "should update routine record", vcr: true do
        @update_routine = @connect.update_routine(ENV['PARTNER_USER_ID'], "54aeed4d98b4b12cee00019d", calories_burned: 10.0)
        @update_routine.should_not be_nil
        @update_routine.routine.calories_burned.should eq 10.0
        @update_routine.routine.source.should eq "healthy_yet"
      end
    end

    context "#delete_routine" do
      it "should delete routine record", vcr: true do
        @delete_routine = @connect.delete_routine(ENV['PARTNER_USER_ID'], "54aeed4d98b4b12cee00019d")
        @delete_routine.code.should eq 200
      end
    end
  end

end
