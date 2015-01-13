# encoding: utf-8
require 'spec_helper'
require 'json'

describe Validic::REST::Sleep do
  let(:client) { Validic::Client.new }

  describe "#get_sleeps" do
    context 'no user_id given' do
      before do
        stub_get("/organizations/#{ENV['TEST_ORG_ID']}/sleep.json").
          with(query: { access_token: ENV['TEST_ORG_TOKEN'] }).
          to_return(body: fixture('sleeps.json'),
                    headers: { content_type: 'application/json; charset=utf-8' })

        @sleep = client.get_sleep
      end

      it 'returns a validic response object' do
        expect(@sleep).to be_a Validic::Response
      end

      it 'makes a sleep request to the correct url' do
        url = "#{Validic::BASE_URL}/organizations/#{ENV['TEST_ORG_ID']}/sleep.json"
        expect(a_request(:get, url).
               with(query: { access_token: ENV['TEST_ORG_TOKEN'] })).
        to have_been_made
      end
    end

    context 'with user_id' do
      before do
        stub_get("/organizations/#{ENV['TEST_ORG_ID']}/users/#{ENV['TEST_USER_ID']}/sleep.json").
          with(query: { access_token: ENV['TEST_ORG_TOKEN'] }).
          to_return(body: fixture('bulk_sleeps.json'),
                    headers: { content_type: 'application/json; charset=utf-8' })
        @sleep = client.get_sleep(user_id: ENV['TEST_USER_ID'])
      end

      it 'returns a validic response object' do
        expect(@sleep).to be_a Validic::Response
      end

      it 'makes a sleep request to the correct url' do
        url = "#{Validic::BASE_URL}/organizations/#{ENV['TEST_ORG_ID']}/users/#{ENV['TEST_USER_ID']}/sleep.json"
        expect(a_request(:get, url).
               with(query: { access_token: ENV['TEST_ORG_TOKEN'] })).
        to have_been_made
      end
    end
  end

  describe '#create_sleep' do
    before do
      stub_post("/organizations/#{ENV['TEST_ORG_ID']}/users/51552cd7fded0807c4000017/sleep.json").
        with(body: { access_token: 'e7ba1f04e88f25d399a91c8cbcd72300e01309e96b7725e40b49cd1effaa5deb',
                     sleep: { timestamp: '2013-03-10T07:12:16+00:00',
                              utc_offset: '+00:00', total_sleep: 477,
                              awake: 34, deep: 234, light: 94, rem: 115,
                              times_woken: 4, activity_id: '12345',
                              extras: nil }}.to_json).
                              to_return(body: fixture('sleep.json'),
                                        headers: { content_type: 'application/json; charset=utf-8'} )
    end

    it 'returns a sleep object' do
      @sleep = client.create_sleep('51552cd7fded0807c4000017', '12345',
                                   timestamp: "2013-03-10T07:12:16+00:00",
                                   utc_offset: "+00:00",
                                   total_sleep: 477,
                                   awake: 34,
                                   deep: 234,
                                   light: 94,
                                   rem: 115,
                                   times_woken: 4,
                                   access_token: 'e7ba1f04e88f25d399a91c8cbcd72300e01309e96b7725e40b49cd1effaa5deb')

      expect(@sleep).to be_a Validic::Sleep
    end
  end


  describe "#update_sleep" do
    before do
      stub_put("/organizations/#{ENV['TEST_ORG_ID']}/users/#{ENV['TEST_USER_ID']}/sleep/51552cddfded0807c4000096.json").
        with(body: { access_token: ENV['TEST_ORG_TOKEN'],
                     sleep: { timestamp: '2013-03-10T07:12:16+00:00',
                              utc_offset: '+00:00', total_sleep: 477,
                              awake: 224, deep: 234, light: 94, rem: 115,
                              times_woken: 4, extras: nil }}.to_json).
                              to_return(body: fixture('sleep.json'),
                                        headers: {content_type: 'application/json; charset=utf-8'})

      @sleep = client.update_sleep(ENV['TEST_USER_ID'], "51552cddfded0807c4000096",
                                  timestamp: "2013-03-10T07:12:16+00:00",
                                  utc_offset: "+00:00",
                                  total_sleep: 477,
                                  awake: 224,
                                  deep: 234,
                                  light: 94,
                                  rem: 115,
                                  times_woken: 4)
    end

    it 'returns sleep obj' do
      expect(@sleep).to be_a Validic::Sleep
    end

    it 'makes a sleep request to the correct url' do
      url = "#{Validic::BASE_URL}/organizations/#{ENV['TEST_ORG_ID']}/users/#{ENV['TEST_USER_ID']}/sleep/51552cddfded0807c4000096.json"

      expect(a_request(:put, url)).to have_been_made
    end

  end
end
