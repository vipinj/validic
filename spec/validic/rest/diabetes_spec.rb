# encoding: utf-8
require 'spec_helper'

describe Validic::REST::Diabetes do
  let(:client) { Validic::Client.new }

  describe "#get_diabetes_records" do
    context 'no user_id given' do
      before do
        stub_get("/organizations/1/diabetes_record.json")
          .with(query: { access_token: '1' })
          .to_return(body: fixture('diabetes_records.json'),
        headers: { content_type: 'application/json; charset=utf-8' })
      end
      it 'returns a validic response object' do
        diabetes_record = client.get_diabetes_record
        expect(diabetes_record).to be_a Validic::Response
      end
      it 'makes a diabetes_record request to the correct url' do
        client.get_diabetes_record
        expect(a_get('/organizations/1/diabetes_record.json').with(query: { access_token: '1' })).to have_been_made
      end
    end
    context 'with user_id' do
      before do
        stub_get("/organizations/1/users/1/diabetes_record.json")
          .with(query: { access_token: '1' })
          .to_return(body: fixture('bulk_diabetes_records.json'),
        headers: { content_type: 'application/json; charset=utf-8' })
      end
      it 'returns a Response' do
        diabetes_record = client.get_diabetes_record(user_id: '1')
        expect(diabetes_record).to be_a Validic::Response
      end
      it 'makes a diabetes_record request to the correct url' do
        client.get_diabetes_record(user_id: '1')
        expect(a_get('/organizations/1/users/1/diabetes_record.json').with(query: { access_token: '1' })).to have_been_made
      end
    end
  end

  describe '#create_diabetes_record' do
    before do
      stub_post("/organizations/1/users/1/diabetes_record.json")
        .with(body: { diabetes_record: { timestamp: '2013-03-10T07:12:16+00:00', activity_id: '12345' },
                      access_token: '1' }.to_json)
        .to_return(body: fixture('diabetes_record.json'),
          headers: { content_type: 'application/json; charset=utf-8'} )
    end
    it 'requests the correct resource' do
      client.create_diabetes_record('1', timestamp: '2013-03-10T07:12:16+00:00', activity_id: '12345')
      expect(a_post('/organizations/1/users/1/diabetes_record.json')
        .with(body: { diabetes_record: { timestamp: '2013-03-10T07:12:16+00:00',
                                   activity_id: '12345' },
                      access_token: '1' }.to_json)).to have_been_made
    end
    it 'returns a Diabetes' do
      diabetes_record = client.create_diabetes_record('1', timestamp: '2013-03-10T07:12:16+00:00', activity_id: '12345')
      expect(diabetes_record).to be_a Validic::Diabetes
      expect(diabetes_record.timestamp).to eq '2013-03-10T07:12:16+00:00'
    end
  end

  describe "#update_diabetes_record" do
    before do
      stub_put("/organizations/1/users/1/diabetes_record/51552cddfded0807c4000096.json")
        .with(body: { diabetes_record: { timestamp: '2013-03-10T07:12:16+00:00' },
                                   access_token: '1' }.to_json)
        .to_return(body: fixture('diabetes_record.json'),
                   headers: {content_type: 'application/json; charset=utf-8'})
    end
    it 'makes a diabetes_record request to the correct url' do
      client.update_diabetes_record('1', '51552cddfded0807c4000096', timestamp: '2013-03-10T07:12:16+00:00')
      expect(a_put('/organizations/1/users/1/diabetes_record/51552cddfded0807c4000096.json')
        .with(body: { diabetes_record: { timestamp: '2013-03-10T07:12:16+00:00' },
                      access_token: '1' }.to_json)).to have_been_made
    end
    it 'returns a Diabetes' do
      diabetes_record = client.update_diabetes_record('1', '51552cddfded0807c4000096', timestamp: '2013-03-10T07:12:16+00:00')
      expect(diabetes_record).to be_a Validic::Diabetes
    end
  end

  describe '#delete_diabetes_record' do
    context 'when resource is found' do
      before do
        stub_delete("/organizations/1/users/1/diabetes_record/51552cddfded0807c4000096.json")
          .to_return(status: 200)
      end
      it 'returns true' do
        diabetes_record = client.delete_diabetes_record('1', '51552cddfded0807c4000096')
        expect(diabetes_record).to be true
      end
    end
  end

  describe '#latests_diabetes_record' do
    context 'with user_id' do
      before do
        stub_get("/organizations/1/users/2/diabetes_record/latest.json").
          with(query: { access_token: '1' }).
          to_return(body: fixture('diabetes_records.json'),
                    headers: { content_type: 'application/json; charset=utf-8' })
          @latest = client.latest_diabetes_record(user_id: '2')
      end
      it 'makes a latest for diabetes_record' do
        expect(@latest).to be_a Validic::Response
      end
      it 'builds a latest url' do
        expect(a_get('/organizations/1/users/2/diabetes_record/latest.json').with(query: { access_token: '1' })).to have_been_made
      end
    end
    context 'without user_id' do
      before do
        stub_get("/organizations/1/diabetes_record/latest.json").
          with(query: { access_token: '1' }).
          to_return(body: fixture('diabetes_records.json'),
                    headers: { content_type: 'application/json; charset=utf-8' })
          @latest = client.latest_diabetes_record
      end
      it 'makes a latest for diabetes_record' do
        expect(@latest).to be_a Validic::Response
      end
      it 'builds a latest url' do
        expect(a_get('/organizations/1/diabetes_record/latest.json').with(query: { access_token: '1' })).to have_been_made
      end
    end
  end
end
