# encoding: utf-8
require 'spec_helper'

describe Validic::Weight do

  let(:client) { Validic::Client.new }

  context "#get_weights" do
    before do
      @weight = client.get_weights({})
    end

    it "returns JSON response of Validic::Weight", vcr: true do
      expect(@weight).not_to be_nil
    end

    it "status 200" do
      expect(@weight.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@weight.summary).not_to be_nil
    end
  end

  context "#get_weights by organization" do
    before do
      @weight = client.get_weights({organization_id: ENV['TEST_ORG_ID'], access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Weight", vcr: true do
      expect(@weight).not_to be_nil
    end

    it "status 200" do
      expect(@weight.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@weight.summary).not_to be_nil
    end
  end

  context "#get_weights by user" do
    before do
      @weight = client.get_weights({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::Weight", vcr: true do
      expect(@weight).not_to be_nil
    end

    it "status 200" do
      expect(@weight.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@weight.summary).not_to be_nil
    end
  end

  context "Validic Connect" do
    before do
      @connect = Validic::Client.new(organization_id: ENV['PARTNER_ORG_ID'],
                                     access_token: ENV['PARTNER_ACCESS_TOKEN'],
                                     api_url: 'https://api.validic.com',
                                     api_version: 'v1')
    end

    context "#create_weight" do
      it "should create new weight record", vcr: true do
        @new_weight = @connect.create_weight(ENV['PARTNER_USER_ID'], "weight_5")
        expect(@new_weight).not_to be_nil
        expect(@new_weight.weight.activity_id).to eq 'weight_5'
        expect(@new_weight.weight.source).to eq "healthy_yet"
      end
    end

    context "#update_weight" do
      it "should update weight record", vcr: true do
        @update_weight = @connect.update_weight(ENV['PARTNER_USER_ID'], "54aecd4398b4b177a900017c", weight: 10.0)
        expect(@update_weight).not_to be_nil
        expect(@update_weight.weight.weight).to eq 10.0
        expect(@update_weight.weight.source).to eq "healthy_yet"
      end
    end

    context "#delete_weight" do
      it "should delete weight record", vcr: true do
        @delete_weight = @connect.delete_weight(ENV['PARTNER_USER_ID'], "54aecd4398b4b177a900017c")
        expect(@delete_weight.code).to eq 200
      end
    end
  end

end
