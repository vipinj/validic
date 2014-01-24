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
    it "should create new nutrition record" do
      pending
      @new_nutrition = client.create_nutrition({authentication_token: "mqwpDx8RYcmSFBJDmy3J",
                                                access_token: "DEMO_KEY",
                                                calories: 850,
                                                carbohydrates: 351,
                                                fat: 52,
                                                fiber: 35,
                                                protein: 54,
                                                sodium: 855,
                                                water: 36,
                                                timestamp: "2013-05-16 07:12:16 -05:00",
                                                meal: "Dinner",
                                                source: "Sample App"})
      @new_nutrition.should_not be_nil
      @new_nutrition.nutrition.timestamp.should eq "2013-05-16 07:12:16 -05:00"
      @new_nutrition.nutrition.calories.should eq 850.0
      @new_nutrition.nutrition.carbohydrates.should eq 351.0
      @new_nutrition.nutrition.fat.should eq 52.0
      @new_nutrition.nutrition.fiber.should eq 35.0
      @new_nutrition.nutrition.protein.should eq 54.0
      @new_nutrition.nutrition.sodium.should eq 855.0
      @new_nutrition.nutrition.water.should eq 36.0
      @new_nutrition.nutrition.meal.should eq "Dinner"
      @new_nutrition.nutrition.source.should eq "Sample App"
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
      @nutrition = client.get_nutritions({user_id: "52967e076dedda5d4300000b"})
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
