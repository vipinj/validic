# encoding: utf-8
require 'spec_helper'

describe Validic::Weight do

  let(:client) { Validic::Client.new }

  context "#get_weights" do
    before do
      @weight = client.get_weights({})
    end

    it "returns JSON response of Validic::Weight", vcr: true do
      @weight.should_not be_nil
    end

    it "status 200" do
      @weight.summary.status.should == 200
    end

    it "has summary node" do
      @weight.summary.should_not be_nil
    end
  end

  context "#create_weight" do
    it "should create new weight record", vcr: true do
      @new_weight = client.create_weight(ENV['PARTNER_USER_ID'], 'weight_1', organization_id: ENV['PARTNER_ORG_ID'], access_token: ENV['PARTNER_ACCESS_TOKEN'], timestamp: "2015-01-06T16:14:17+00:00")
      @new_weight.should_not be_nil
      @new_weight.weight.timestamp.should eq "2015-01-06T16:14:17+00:00"
      @new_weight.weight.activity_id.should eq 'weight_1'
      @new_weight.weight.source.should eq "healthy_yet"
    end
  end

  context "#get_weights by organization" do
    before do
      @weight = client.get_weights({organization_id: "51aca5a06dedda916400002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Weight", vcr: true do
      @weight.should_not be_nil
    end

    it "status 200" do
      @weight.summary.status.should == 200
    end

    it "has summary node" do
      @weight.summary.should_not be_nil
    end
  end

  context "#get_weights by user" do
    before do
      @weight = client.get_weights({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::Weight", vcr: true do
      @weight.should_not be_nil
    end

    it "status 200" do
      @weight.summary.status.should == 200
    end

    it "has summary node" do
      @weight.summary.should_not be_nil
    end
  end

end
