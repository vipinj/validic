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
      @user_biometrics.should_not be_nil
    end

    it "status 200" do
      @user_biometrics.summary.status.should == 200
    end

    context "#summary response" do
      it "not nil" do
        @user_biometrics.summary.should_not be_nil
      end

      it "results not 0" do
        @user_biometrics.summary.results.should_not == 0
      end
    end

    context "#biometrics collection" do
      it "has a collection" do
        @user_biometrics.biometrics.should be_a(Array)
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
        @new_biometric = @connect.create_biometric(ENV['PARTNER_USER_ID'], "biometric_2")
        @new_biometric.should_not be_nil
        @new_biometric.biometrics.activity_id.should eq 'biometric_2'
        @new_biometric.biometrics.source.should eq "healthy_yet"
      end
    end

    context "#update_biometric" do
      pending "should update biometric record", vcr: true do
        @update_biometric = @connect.update_biometric(ENV['PARTNER_USER_ID'], "54aeb32c68c652cd11000111", blood_calcium: 10.0)
        @update_biometric.should_not be_nil
        @update_biometric.biometrics.blood_calcium.should eq 10.0
        @update_biometric.biometrics.source.should eq "healthy_yet"
      end
    end

    context "#delete_biometric" do
      pending "should delete biometric record", vcr: true do
        @delete_biometric = @connect.delete_biometric(ENV['PARTNER_USER_ID'], "54aeb32c68c652cd11000111")
        @delete_biometric.code.should eq 200
      end
    end
  end

end
