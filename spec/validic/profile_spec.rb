# encoding: utf-8
require 'spec_helper'

describe Validic::Profile do

  let(:client) { Validic::Client.new }

  context "#get_profile" do
    before do
      @profile = client.get_profile({})
    end

    it "returns JSON response of Validic::Profile", vcr: true do
      @profile.should_not be_nil
    end
  end

  # context "#update_profile" do
  #   before do
  #     @updated_profile = client.update_profile({gender: "M",
  #                                               location: "TX",
  #                                               birth_year: "1985",
  #                                               height: 168.75,
  #                                               weight: 69,
  #                                               first_name: "Demo",
  #                                               last_name: "User"})
  #   end

  #   it "should return gender" do
  #     @updated_profile.profile.gender.should eq 'M'
  #   end

  #   it "should return location" do
  #     @updated_profile.profile.location.should eq 'TX'
  #   end

  #   it "should return height" do
  #     @updated_profile.profile.height.should eq "168.75"
  #   end

  #   it "should return weight" do
  #     @updated_profile.profile.weight.should eq 69
  #   end
  # end

end
