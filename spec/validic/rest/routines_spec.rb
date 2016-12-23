require 'spec_helper'

describe Validic::REST::Routines do
  let(:client) { Validic::Client.new }

  describe "#get_routines" do
    context 'no user_id given' do
      before do
        stub_get('/organizations/1/routine/intraday.json')
          .with(query: { access_token: '1' })
          .to_return(body: fixture('routine_intraday.json'),
        headers: { content_type: 'application/json; charset=utf-8' })
      end
      it 'returns a validic response object' do
        routines = client.get_routines
        expect(routines).to be_a Validic::Response
      end
      it 'makes a routine request to the correct url' do
        client.get_routines
        expect(a_get('/organizations/1/routine/intraday.json').with(query: { access_token: '1' })).to have_been_made
      end
    end
    context 'with user_id' do
      before do
        stub_get('/organizations/1/users/1/routine/intraday.json')
          .with(query: { access_token: '1' })
          .to_return(body: fixture('routine_intraday.json'), headers: { content_type: 'application/json; charset=utf-8' })
      end
      it 'returns a Response' do
        routines = client.get_routines(user_id: '1')
        expect(routines).to be_a Validic::Response
      end
      it 'makes a routine request to the correct url' do
        client.get_routines(user_id: '1')
        expect(a_get('/organizations/1/users/1/routine/intraday.json').with(query: { access_token: '1' })).to have_been_made
      end
    end
  end

  describe '#latest_routine' do
    context 'with user_id' do
      before do
        stub_get("/organizations/1/users/2/routine/intraday/latest.json").
          with(query: { access_token: '1' }).
          to_return(body: fixture('routine_intraday.json'),
                    headers: { content_type: 'application/json; charset=utf-8' })
      end
      it 'makes a latest for routine' do
        latest = client.latest_routines(user_id: '2')
        expect(latest).to be_a Validic::Response
      end
      it 'builds a latest url' do
        client.latest_routines(user_id: '2')
        expect(a_get('/organizations/1/users/2/routine/intraday/latest.json').with(query: { access_token: '1' })).to have_been_made
      end
    end
    context 'without user_id' do
      before do
        stub_get("/organizations/1/routine/intraday/latest.json").
          with(query: { access_token: '1' }).
          to_return(body: fixture('routine_intraday.json'),
                    headers: { content_type: 'application/json; charset=utf-8' })
      end
      it 'makes a latest for routine' do
        latest = client.latest_routines
        expect(latest).to be_a Validic::Response
      end
      it 'builds a latest url' do
        client.latest_routines
        expect(a_get('/organizations/1/routine/intraday/latest.json').with(query: { access_token: '1' })).to have_been_made
      end
    end
  end
end
