# encoding: utf-8
require 'spec_helper'

describe Validic::Diabetes do

  let(:client) { Validic::Client.new }

  context "#get_diabetes" do
    before do
      @diabetes = client.get_diabetes({})
    end

    it "returns JSON response of Validic::diabetes", vcr: true do
      @diabetes.should_not be_nil
    end

    it "status 200" do
      @diabetes.summary.status.should == 200 
    end

    it "has summary node" do
      @diabetes.summary.should_not be_nil
    end
  end

  context "#create_diabetes" do
    it "should create new diabetes record" do
      @new_diabetes = client.create_diabetes({c_peptide: 1,
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

end
