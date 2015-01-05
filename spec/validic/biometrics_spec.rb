# encoding: utf-8
require 'spec_helper'
require 'pry'

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

end
