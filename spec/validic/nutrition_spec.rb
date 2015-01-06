# encoding: utf-8
require 'spec_helper'

describe Validic::Nutrition do

  let(:client) { Validic::Client.new }

  context "#get_nutritions" do
    before do
      @nutrition = client.get_nutritions({})
    end

    it "returns JSON response of Validic::Nutrition", vcr: true do
      @nutrition.should_not be_nil
    end

    it "status 200" do
      @nutrition.summary.status.should == 200
    end

    it "has summary node" do
      @nutrition.summary.should_not be_nil
    end
  end

  context "#create_nutrition" do
    it "should create new nutrition record", vcr: true do
      @new_nutrition = client.create_nutrition(ENV['PARTNER_USER_ID'], 'nutrition_1', organization_id: ENV['PARTNER_ORG_ID'], access_token: ENV['PARTNER_ACCESS_TOKEN'], timestamp: "2015-01-06T16:14:17+00:00")
      @new_nutrition.should_not be_nil
      @new_nutrition.nutrition.timestamp.should eq "2015-01-06T16:14:17+00:00"
      @new_nutrition.nutrition.activity_id.should eq 'nutrition_1'
      @new_nutrition.nutrition.source.should eq "healthy_yet"
    end
  end

  context "#get_nutritions by organization" do
    before do
      @nutrition = client.get_nutritions({organization_id: "51aca5a06dedda916400002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Nutrition", vcr: true do
      @nutrition.should_not be_nil
    end

    it "status 200" do
      @nutrition.summary.status.should == 200
    end

    it "has summary node" do
      @nutrition.summary.should_not be_nil
    end
  end

  context "#get_nutritions by user" do
    before do
      @nutrition = client.get_nutritions({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::Nutrition", vcr: true do
      @nutrition.should_not be_nil
    end

    it "status 200" do
      @nutrition.summary.status.should == 200
    end

    it "has summary node" do
      @nutrition.summary.should_not be_nil
    end
  end

end
