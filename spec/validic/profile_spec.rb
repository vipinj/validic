# encoding: utf-8
require 'spec_helper'

describe Validic::Profile do

  let(:client) { Validic::Client.new }

  context "#get_profile" do
    before do
      @profile = client.get_profile(ENV['TEST_USER_AUTHENTICATION_TOKEN'])
    end

    it "returns JSON response of Validic::Profile", vcr: true do
      @profile.should_not be_nil
    end
  end

  context "#create_profile" do
    it "adds a profile to an existing user", vcr: true do
      @profile = client.create_profile(ENV['TEST_USER_AUTHENTICATION_TOKEN'],
                                       gender: "F",
                                       location: "CA",
                                       country: "USA",
                                       birth_year: "1987",
                                       height: 60.0,
                                       weight: 140)
      @profile.should_not be_nil
    end
  end

end
