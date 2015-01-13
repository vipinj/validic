# encoding: utf-8
require 'spec_helper'

describe Validic::REST::Sleep do

  let(:client) { Validic::Client.new }

  describe "#get_sleeps" do
    context 'no user_id given' do
      before do
        stub_get("/organizations/#{ENV['TEST_ORG_ID']}/sleep.json").
          with(query: { access_token: ENV['TEST_ORG_TOKEN'] }).
          to_return(body: fixture('sleep.json'), query: { access_token: ENV['TEST_ORG_TOKEN'] }, headers: {content_type: 'application/json; charset=utf-8'})
        @sleep = client.get_sleep
      end

      it 'returns an array of sleep objects' do
        expect(@sleep).to be_kind_of Validic::Response
      end

      it 'makes a sleep request' do
        url = "#{Validic::BASE_URL}/organizations/#{ENV['TEST_ORG_ID']}/sleep.json"
        expect(a_request(:get, url).with(query: { access_token: ENV['TEST_ORG_TOKEN'] })).to have_been_made
      end
    end

    context 'with user_id' do
      before do
        stub_get("/organizations/#{ENV['TEST_ORG_ID']}/users/#{ENV['TEST_USER_ID']}/sleep.json").
          with(query: { access_token: ENV['TEST_ORG_TOKEN'] }).
          to_return(body: fixture('bulk_sleep.json'), query: { access_token: ENV['TEST_ORG_TOKEN'] }, headers: {content_type: 'application/json; charset=utf-8'})
        @sleep = client.get_sleep(user_id: ENV['TEST_USER_ID'])
      end

      it 'returns an array of sleep objects' do
        expect(@sleep).to be_kind_of Validic::Response
      end

      it 'makes a sleep request' do
        url = "#{Validic::BASE_URL}/organizations/#{ENV['TEST_ORG_ID']}/users/#{ENV['TEST_USER_ID']}/sleep.json"
        expect(a_request(:get, url).with(query: { access_token: ENV['TEST_ORG_TOKEN'] })).to have_been_made
      end
    end

  end
end
