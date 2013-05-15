# encoding: utf-8
require 'spec_helper'

describe Validic::User do

  let(:client) { Validic::Client.new }

  context "#me" do
    before do
      @me = client.me({})
    end

    it "returns JSON response of Validic::User", vcr: true do
      @me.should_not be_nil
    end

    it "should return the user id" do
      @me.user._id.should_not be_nil
    end

    it "should return the user profile" do
      @me.user.profile.should_not be_nil
    end

  end

end

