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

  context "Validic Connect" do
    before do
      @connect = Validic::Client.new(organization_id: ENV['PARTNER_ORG_ID'],
                                     access_token: ENV['PARTNER_ACCESS_TOKEN'],
                                     api_url: 'https://api.validic.com',
                                     api_version: 'v1')
    end

    context "#create_sleep" do
      it "should create new sleep record", vcr: true do
        @new_sleep = @connect.create_sleep(ENV['PARTNER_USER_ID'], "sleepz")
        @new_sleep.should_not be_nil
        @new_sleep.sleep.activity_id.should eq "sleepz"
        @new_sleep.sleep.source.should eq "healthy_yet"
      end
    end

    context "#update_sleep" do
      it "should update sleep record", vcr: true do
        @update_sleep = @connect.update_sleep(ENV['PARTNER_USER_ID'], "54aeef3984626b1806000246", awake: 10.0)
        @update_sleep.should_not be_nil
        @update_sleep.sleep.awake.should eq 10.0
        @update_sleep.sleep.source.should eq "healthy_yet"
      end
    end

    context "#delete_sleep" do
      it "should delete sleep record", vcr: true do
        @delete_sleep = @connect.delete_sleep(ENV['PARTNER_USER_ID'], "54aeef3984626b1806000246")
        @delete_sleep.code.should eq 200
      end
    end
  end

end
