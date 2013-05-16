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
    it "should create new sleep record" do
      @new_sleep = client.create_sleep({total_sleep: 210,
                                        awake: 10,
                                        deep: 120,
                                        light: 50,
                                        rem: 30,
                                        times_woken: 3,
                                        timestamp: "2013-05-16 07:12:16 -05:00",
                                        source: "Sample App"})
      @new_sleep.should_not be_nil
      @new_sleep.sleep.timestamp.should eq "2013-05-16 07:12:16 -05:00"
      @new_sleep.sleep.total_sleep.should eq 210.0
      @new_sleep.sleep.awake.should eq 10.0
      @new_sleep.sleep.deep.should eq 120.0
      @new_sleep.sleep.light.should eq 50.0
      @new_sleep.sleep.rem.should eq 30.0
      @new_sleep.sleep.times_woken.should eq 3.0
      @new_sleep.sleep.source.should eq "Sample App"
    end
  end

end
