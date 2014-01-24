# encoding: utf-8
require 'spec_helper'

describe Validic do

  let(:client) { Validic::Client.new }

  context "configure defaults" do

    it "uses default API URL" do
      client.api_url.should eq 'https://api.validic.com'
    end

    it "uses default API VERSION" do
      client.api_version.should eq 'v1'
    end

  end

  context "handles custom configuration" do
    let(:new_client) { Validic::Client
                       .new(api_url: 'https://api.validic.net',
                            api_version: 'v2',
                           organization_id: '1234567') }

    it "::Client API_URL configuration" do
      new_client.api_url.should eq 'https://api.validic.net'
    end

    it "::Client API_VERSION configuration" do
      new_client.api_version.should eq 'v2'
    end

    it "::Client Organization ID configuration" do
      new_client.organization_id.should eq '1234567'
    end
  end

end
