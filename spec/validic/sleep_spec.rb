# encoding: utf-8
require 'spec_helper'

describe Validic::Sleep do

  let(:client) { Validic::Client.new }

  context "#get_sleeps" do
    before do
      @sleep = client.get_sleeps({})
    end

    it "returns JSON response of Validic::Sleep", vcr: true do
      expect(@sleep).not_to be_nil
    end

    it "status 200" do
      expect(@sleep.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@sleep.summary).not_to be_nil
    end
  end

  context "#get_sleeps by organization" do
    before do
      @sleep = client.get_sleeps({organization_id: "51aca5a06dedda916400002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Sleep", vcr: true do
      expect(@sleep).not_to be_nil
    end

    it "status 200" do
      expect(@sleep.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@sleep.summary).not_to be_nil
    end
  end

  context "#get_sleeps by user" do
    before do
      @sleep = client.get_sleeps({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::Sleep", vcr: true do
      expect(@sleep).not_to be_nil
    end

    it "status 200" do
      expect(@sleep.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@sleep.summary).not_to be_nil
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
        expect(@new_sleep).not_to be_nil
        expect(@new_sleep.sleep.activity_id).to eq "sleepz"
        expect(@new_sleep.sleep.source).to eq "healthy_yet"
      end
    end

    context "#update_sleep" do
      it "should update sleep record", vcr: true do
        @update_sleep = @connect.update_sleep(ENV['PARTNER_USER_ID'], "54aeef3984626b1806000246", awake: 10.0)
        expect(@update_sleep).not_to be_nil
        expect(@update_sleep.sleep.awake).to eq 10.0
        expect(@update_sleep.sleep.source).to eq "healthy_yet"
      end
    end

    context "#delete_sleep" do
      it "should delete sleep record", vcr: true do
        @delete_sleep = @connect.delete_sleep(ENV['PARTNER_USER_ID'], "54aeef3984626b1806000246")
        expect(@delete_sleep.code).to eq 200
      end
    end
  end

end
