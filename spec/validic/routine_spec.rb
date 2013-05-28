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
    it "should create new routine record" do
      @new_routine = client.create_routine({access_token: "DEMO_KEY",
                                            timestamp: "2013-05-16 07:12:16 -05:00",
                                            steps: 10000,
                                            stairs_climbed: 50,
                                            calories_burned: 2500,
                                            calories_consumed: 3000,
                                            source: "Sample App"})
      @new_routine.should_not be_nil
      @new_routine.routine.timestamp.should eq "2013-05-16 07:12:16 -05:00"
      @new_routine.routine.steps.should eq 10000.0
      @new_routine.routine.stairs_climbed.should eq 50.0
      @new_routine.routine.calories_burned.should eq 2500.0
      @new_routine.routine.calories_consumed.should eq 3000.0
      @new_routine.routine.source.should eq "Sample App"
    end
  end

  context "#get_routines by organization" do
    before do
      @routine = client.get_routines({organization_id: "51945d536a7e0cb3db000029", access_token: "ENTERPRISE_KEY"})
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
