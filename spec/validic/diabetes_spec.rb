# encoding: utf-8
require 'spec_helper'

describe Validic::Diabetes do

  let(:client) { Validic::Client.new }

  context "#get_diabetes" do
    before do
      @user_diabetes = client.get_diabetes({})
    end

    it "returns JSON response of Validic::Diabetes", vcr: true do
      expect(@user_diabetes).not_to be_nil
    end

    it "status 200" do
      expect(@user_diabetes.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@user_diabetes.summary).not_to be_nil
    end
  end

  context "#get_diabetes by organization" do
    before do
      @org_diabetes = client.get_diabetes({organization_id: "51aca5a06dedda916400002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Diabetes", vcr: true do
      expect(@org_diabetes).not_to be_nil
    end

    it "status 200" do
      expect(@org_diabetes.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@org_diabetes.summary).not_to be_nil
    end
  end

  context "#get_diabetes by user" do
    before do
      @user_diabetes = client.get_diabetes({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::Diabetes", vcr: true do
      expect(@user_diabetes).not_to be_nil
    end

    it "status 200" do
      expect(@user_diabetes.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@user_diabetes.summary).not_to be_nil
    end
  end

  context "Validic Connect" do
    before do
      @connect = Validic::Client.new(organization_id: ENV['PARTNER_ORG_ID'],
                                     access_token: ENV['PARTNER_ACCESS_TOKEN'],
                                     api_url: 'https://api.validic.com',
                                     api_version: 'v1')
    end

    context "#create_diabetes" do
      it "should create new diabetes record", vcr: true do
        @new_diabetes = @connect.create_diabetes(ENV['PARTNER_USER_ID'], "diabetes_2015abc")
        expect(@new_diabetes).not_to be_nil
        expect(@new_diabetes.diabetes.activity_id).to eq "diabetes_2015abc"
        expect(@new_diabetes.diabetes.source).to eq "healthy_yet"
      end
    end

    context "#update_diabetes" do
      it "should update diabetes record", vcr: true do
        @update_diabetes = @connect.update_diabetes(ENV['PARTNER_USER_ID'], "54aeb3c784626b2faf000230", insulin: 10.0)
        expect(@update_diabetes).not_to be_nil
        expect(@update_diabetes.diabetes.insulin).to eq 10.0
        expect(@update_diabetes.diabetes.source).to eq "healthy_yet"
      end
    end

    context "#delete_diabetes" do
      it "should delete diabetes record", vcr: true do
        @delete_diabetes = @connect.delete_diabetes(ENV['PARTNER_USER_ID'], "54aeb3c784626b2faf000230")
        expect(@delete_diabetes.code).to eq 200
      end
    end
  end

end
