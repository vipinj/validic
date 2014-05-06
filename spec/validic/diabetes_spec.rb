# encoding: utf-8
require 'spec_helper'

describe Validic::Diabetes do

  let(:client) { Validic::Client.new }

  context "#get_diabetes" do
    before do
      @user_diabetes = client.get_diabetes({})
    end

    it "returns JSON response of Validic::Diabetes", vcr: true do
      @user_diabetes.should_not be_nil
    end

    it "status 200" do
      @user_diabetes.summary.status.should == 200
    end

    it "has summary node" do
      @user_diabetes.summary.should_not be_nil
    end
  end

  context "#create_diabetes" do
    it "should create new diabetes record", vcr: true do
      pending
      @new_diabetes = client.create_diabetes({authentication_token: ENV['TEST_USER_AUTHENTICATION_TOKEN'],
                                              access_token: "DEMO_KEY",
                                              c_peptide: 1,
                                              fasting_plasma_glucose_test: 50,
                                              hba1c: 100,
                                              insulin: 350,
                                              oral_glucose_tolerance_test: 100,
                                              random_plasma_glucose_test: 200,
                                              triglyceride: 100,
                                              timestamp: "2013-05-16 07:12:16 -05:00",
                                              source: "Sample App"})
      @new_diabetes.should_not be_nil
      @new_diabetes.diabetes.timestamp.should eq "2013-05-16 07:12:16 -05:00"
      @new_diabetes.diabetes.c_peptide.should eq 1.0
      @new_diabetes.diabetes.fasting_plasma_glucose_test.should eq 50.0
      @new_diabetes.diabetes.hba1c.should eq 100.0
      @new_diabetes.diabetes.insulin.should eq 350.0
      @new_diabetes.diabetes.oral_glucose_tolerance_test.should eq 100.0
      @new_diabetes.diabetes.random_plasma_glucose_test.should eq 200.0
      @new_diabetes.diabetes.triglyceride 100.0
      @new_diabetes.diabetes.source.should eq "Sample App"
    end
  end

  context "#get_diabetes by organization" do
    before do
      @org_diabetes = client.get_diabetes({organization_id: "51aca5a06dedda916400002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Diabetes", vcr: true do
      @org_diabetes.should_not be_nil
    end

    it "status 200" do
      @org_diabetes.summary.status.should == 200 
    end

    it "has summary node" do
      @org_diabetes.summary.should_not be_nil
    end
  end

  context "#get_diabetes by user" do
    before do
      @user_diabetes = client.get_diabetes({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::Diabetes", vcr: true do
      @user_diabetes.should_not be_nil
    end

    it "status 200" do
      @user_diabetes.summary.status.should == 200 
    end

    it "has summary node" do
      @user_diabetes.summary.should_not be_nil
    end
  end

end
