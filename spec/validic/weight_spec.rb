# encoding: utf-8
require 'spec_helper'

describe Validic::Weight do

  let(:client) { Validic::Client.new }

  context "#get_weights" do
    before do
      @weight = client.get_weights({})
    end

    it "returns JSON response of Validic::Weight", vcr: true do
      @weight.should_not be_nil
    end

    it "status 200" do
      @weight.summary.status.should == 200 
    end

    it "has summary node" do
      @weight.summary.should_not be_nil
    end
  end

  context "#create_weight" do
    it "should create new weight record" do
      @new_weight = client.create_weight({timestamp: "2013-05-16 07:12:16 -05:00",
                                          bmi: 133.26,
                                          fat_percent: 130.5,
                                          mass_weight: 139.45,
                                          free_mass: 140.50,
                                          weight: 69.76,
                                          height: 167.75,
                                          source: "Sample App"})

      @new_weight.should_not be_nil
      @new_weight.weight.timestamp.should eq "2013-05-16 07:12:16 -05:00"
      @new_weight.weight.bmi.should eq 133.26
      @new_weight.weight.fat_percent.should eq 130.5
      @new_weight.weight.mass_weight.should eq 139.45
      @new_weight.weight.height.should eq "167.75"
      @new_weight.weight.free_mass.should eq 140.50
      @new_weight.weight.weight.should eq 69.76
      @new_weight.weight.source.should eq "Sample App"
    end
  end

  context "#get_weights by organization" do
    before do
      @weight = client.get_weights({org_id: "51945d536a7e0cb3db000029", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Weight", vcr: true do
      @weight.should_not be_nil
    end

    it "status 200" do
      @weight.summary.status.should == 200 
    end

    it "has summary node" do
      @weight.summary.should_not be_nil
    end
  end

end
