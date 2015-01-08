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

  context 'Validic Connect' do
    let(:connect) { Validic::Client.new(organization_id: ENV['PARTNER_ORG_ID'],
                                        access_token: ENV['PARTNER_ACCESS_TOKEN'],
                                        api_url: 'https://api.validic.com',
                                        api_version: 'v1')
    }

    let(:user_id) { ENV['PARTNER_USER_ID'] }

    let(:options) { {
        calories: 850,
        carbohydrates: 351,
        fat: 52,
        fiber: 35,
        protein: 54,
        sodium: 855,
        water: 36,
      }}

    it "#create_nutrition", vcr: true do
      new_nutrition = connect.create_nutrition(user_id, 'nutrition134-gem', options)

      new_nutrition.should_not be_nil
      new_nutrition.nutrition.calories.should eq 850.0
      new_nutrition.nutrition.carbohydrates.should eq 351.0
      new_nutrition.nutrition.fat.should eq 52.0
      new_nutrition.nutrition.fiber.should eq 35.0
      new_nutrition.nutrition.protein.should eq 54.0
      new_nutrition.nutrition.sodium.should eq 855.0
      new_nutrition.nutrition.water.should eq 36.0
    end


    it "#update_nutrition", vcr: true do
      new_nutrition = connect.create_nutrition(user_id, 'nutrition85-gem', options)
      update_nutrition = connect.update_nutrition(user_id, new_nutrition.nutrition._id, sodium: 901)

      update_nutrition.should_not be nil
      expect(update_nutrition.nutrition.sodium).to eq 901
    end

    it "#delete_nutrition", vcr: true do
      new_nutrition = connect.create_nutrition(user_id, 'nutrition100-gem', options)
      delete_nutrition = connect.delete_nutrition(user_id, new_nutrition.nutrition._id)

      delete_nutrition.code.should eq 200
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
