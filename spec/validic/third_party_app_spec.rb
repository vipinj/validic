# encoding: utf-8
require 'spec_helper'

describe Validic::ThirdPartyApp do

  let(:client) { Validic::Client.new }

  context "#get_apps" do
    before do
      @app_response = client.get_apps({organization_id: "51aca5a06dedda916400002b", authentication_token: "ef617d9d3bb39b4112f60dc65ee40061165c1ab4375e3ea63896f63a7390c4db"})
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
      @synced_app_response = client.get_synced_apps({authentication_token: "efL6rrKifMK6wYfShJBA"})
    end

    it "returns JSON response of Validic::ThirdPartyApp", vcr: true do
      @synced_app_response.should_not be_nil
    end
  end

end
