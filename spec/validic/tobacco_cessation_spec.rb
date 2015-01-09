# encoding: utf-8
require 'spec_helper'

describe Validic::TobaccoCessation do

  let(:client) { Validic::Client.new }

  context "#get_tobacco_cessation" do
    before do
      @tobacco_cessation = client.get_tobacco_cessations({})
    end

    it "returns JSON response of Validic::TobaccoCessation", vcr: true do
      expect(@tobacco_cessation).not_to be_nil
    end

    it "status 200" do
      expect(@tobacco_cessation.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@tobacco_cessation.summary).not_to be_nil
    end
  end

  context "#get_tobacco_cessations by organization" do
    before do
      @tobacco_cessation = client.get_tobacco_cessations({organization_id: "51aca5a06dedda916400002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::TobaccoCessation", vcr: true do
      expect(@tobacco_cessation).not_to be_nil
    end

    it "status 200" do
      expect(@tobacco_cessation.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@tobacco_cessation.summary).not_to be_nil
    end
  end

  context "#get_tobacco_cessations by user" do
    before do
      @tobacco_cessation = client.get_tobacco_cessations({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::TobaccoCessation", vcr: true do
      expect(@tobacco_cessation).not_to be_nil
    end

    it "status 200" do
      expect(@tobacco_cessation.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@tobacco_cessation.summary).not_to be_nil
    end
  end

  context "Validic Connect" do
    before do
      @connect = Validic::Client.new(organization_id: ENV['PARTNER_ORG_ID'],
                                     access_token: ENV['PARTNER_ACCESS_TOKEN'],
                                     api_url: 'https://api.validic.com',
                                     api_version: 'v1')
    end

    context "#create_tobacco_cessation" do
      it "should create new tobacco_cessation record", vcr: true do
        @new_tobacco_cessation = @connect.create_tobacco_cessation(ENV['PARTNER_USER_ID'], "tobaccoz")
        expect(@new_tobacco_cessation).not_to be_nil
        expect(@new_tobacco_cessation.tobacco_cessation.activity_id).to eq "tobaccoz"
        expect(@new_tobacco_cessation.tobacco_cessation.source).to eq "healthy_yet"
      end
    end

    context "#update_tobacco_cessation" do
      it "should update tobacco_cessation record", vcr: true do
        @update_tobacco_cessation = @connect.update_tobacco_cessation(ENV['PARTNER_USER_ID'], "54aeefec98b4b1cfb5000193", cravings: 10.0)
        expect(@update_tobacco_cessation).not_to be_nil
        expect(@update_tobacco_cessation.tobacco_cessation.cravings).to eq 10.0
        expect(@update_tobacco_cessation.tobacco_cessation.source).to eq "healthy_yet"
      end
    end

    context "#delete_tobacco_cessation" do
      it "should delete tobacco_cessation record", vcr: true do
        @delete_tobacco_cessation = @connect.delete_tobacco_cessation(ENV['PARTNER_USER_ID'], "54aeefec98b4b1cfb5000193")
        expect(@delete_tobacco_cessation.code).to eq 200
      end
    end
  end

end
