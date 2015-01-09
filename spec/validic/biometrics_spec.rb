# encoding: utf-8
require 'spec_helper'

describe Validic::Biometric do

  let(:client) { Validic::Client.new }

  context "#get_biometrics" do
    before do
      @user_biometrics = client
        .get_biometrics({
          start_date: '2014-01-01',
          user_id: ENV['TEST_USER_ID']
        })
    end

    it "returns JSON response of Validic::Biometrics", vcr: true do
      expect(@user_biometrics).not_to be_nil
    end

    it "status 200" do
      expect(@user_biometrics.summary.status).to eq(200)
    end

    context "#summary response" do
      it "not nil" do
        expect(@user_biometrics.summary).not_to be_nil
      end

      it "results not 0" do
        expect(@user_biometrics.summary.results).not_to eq(0)
      end
    end

    context "#biometrics collection" do
      it "has a collection" do
        expect(@user_biometrics.biometrics).to be_a(Array)
      end
    end
  end

  context "Validic Connect" do
    before do
      @connect = Validic::Client.new(organization_id: ENV['PARTNER_ORG_ID'],
                                     access_token: ENV['PARTNER_ACCESS_TOKEN'],
                                     api_url: 'https://api.validic.com',
                                     api_version: 'v1')
    end

    context "#create_biometric" do
      it "should create new biometric record", vcr: true do
        @new_biometric = @connect.create_biometric(ENV['PARTNER_USER_ID'], "biometricz")
        expect(@new_biometric).not_to be_nil
        expect(@new_biometric.biometrics.activity_id).to eq "biometricz"
        expect(@new_biometric.biometrics.source).to eq "healthy_yet"
      end
    end

    context "#update_biometric" do
      it "should update biometric record", vcr: true do
        @update_biometric = @connect.update_biometric(ENV['PARTNER_USER_ID'], "54aeeed898b4b11f9a0001b8", blood_calcium: 10.0)
        expect(@update_biometric).not_to be_nil
        expect(@update_biometric.biometrics.blood_calcium).to eq 10.0
        expect(@update_biometric.biometrics.source).to eq "healthy_yet"
      end
    end

    context "#delete_biometric" do
      it "should delete biometric record", vcr: true do
        @delete_biometric = @connect.delete_biometric(ENV['PARTNER_USER_ID'], "54aeeed898b4b11f9a0001b8")
        expect(@delete_biometric.code).to eq 200
      end
    end
  end

end
