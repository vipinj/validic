# encoding: utf-8
require 'spec_helper'

describe Validic::Nutrition do

  let(:client) { Validic::Client.new }

  context "#get_nutritions" do
    before do
      @nutrition = client.get_nutritions({})
    end

    it "returns JSON response of Validic::Nutrition", vcr: true do
      expect(@nutrition).not_to be_nil
    end

    it "status 200" do
      expect(@nutrition.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@nutrition.summary).not_to be_nil
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

      expect(new_nutrition).not_to be_nil
      expect(new_nutrition.nutrition.calories).to eq 850.0
      expect(new_nutrition.nutrition.carbohydrates).to eq 351.0
      expect(new_nutrition.nutrition.fat).to eq 52.0
      expect(new_nutrition.nutrition.fiber).to eq 35.0
      expect(new_nutrition.nutrition.protein).to eq 54.0
      expect(new_nutrition.nutrition.sodium).to eq 855.0
      expect(new_nutrition.nutrition.water).to eq 36.0
    end


    it "#update_nutrition", vcr: true do
      new_nutrition = connect.create_nutrition(user_id, 'nutrition85-gem', options)
      update_nutrition = connect.update_nutrition(user_id, new_nutrition.nutrition._id, sodium: 901)

      expect(update_nutrition).not_to be nil
      expect(update_nutrition.nutrition.sodium).to eq 901
    end

    it "#delete_nutrition", vcr: true do
      new_nutrition = connect.create_nutrition(user_id, 'nutrition100-gem', options)
      delete_nutrition = connect.delete_nutrition(user_id, new_nutrition.nutrition._id)

      expect(delete_nutrition.code).to eq 200
    end
  end


  context "#get_nutritions by organization" do
    before do
      @nutrition = client.get_nutritions({organization_id: "51aca5a06dedda916400002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Nutrition", vcr: true do
      expect(@nutrition).not_to be_nil
    end

    it "status 200" do
      expect(@nutrition.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@nutrition.summary).not_to be_nil
    end
  end

  context "#get_nutritions by user" do
    before do
      @nutrition = client.get_nutritions({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::Nutrition", vcr: true do
      expect(@nutrition).not_to be_nil
    end

    it "status 200" do
      expect(@nutrition.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@nutrition.summary).not_to be_nil
    end
  end

end
