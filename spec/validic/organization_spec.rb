# encoding: utf-8
require 'spec_helper'

describe Validic::Organization do

  let(:client) { Validic::Client.new }

  context "#get_organization" do
    before do
      @organization_response = client.get_organization({organization_id: ENV['TEST_ORG_ID'], access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Organization", vcr: true do
      expect(@organization_response).not_to be_nil
    end

    it "status 200" do
      expect(@organization_response.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@organization_response.summary).not_to be_nil
    end
  end
end

