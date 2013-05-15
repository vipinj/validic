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

  context "#update_profile" do
    it "should allow to update profile" do
      @updated_profile = client.update_profile({gender: "F",
                                               location: "TX",
                                               birth_year: "1985",
                                               height: 167.75,
                                               weight: 69,
                                               first_name: "Demo",
                                               last_name: "User"})
      @updated_profile.profile.gender.should eq 'F'
      @updated_profile.profile.location.should eq 'TX'
      @updated_profile.profile.height.should eq "167.75"
      @updated_profile.profile.weight.should eq 69
    end
  end

end


