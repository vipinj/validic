# encoding: utf-8
require 'spec_helper'

describe Validic::ThirdPartyApp do

  let(:client) { Validic::Client.new }

  context "#get_apps" do
    before do
      @app_response = client.get_apps
    end

    it "returns JSON response of Validic::ThirdPartyApp", vcr: true do
      @app_response.should_not be_nil
    end

    it "has apps node" do
      @app_response.apps.should_not be_nil
    end
  end

  context "#get_synced_apps" do
    before do
      @synced_app_response = client.get_synced_apps(ENV['TEST_USER_AUTHENTICATION_TOKEN'])
    end

    it "returns JSON response of Validic::ThirdPartyApp", vcr: true do
      @synced_app_response.should_not be_nil
    end
  end

end
