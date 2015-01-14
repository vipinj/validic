require 'spec_helper'

describe Validic::REST::Users do
  let(:client) { Validic::Client.new }

  describe '#provision_user' do
    before do
      stub_post('/organizations/1/users.json')
        .with(body: { user: { uid: '123467890' }, access_token: '1' }.to_json)
        .to_return(body: fixture('user.json'), headers: { content_type: 'application/json; charset=utf-8' })
    end
    it 'requests the correct resource' do
      client.provision_user(uid: '123467890')
      expect(a_post('/organizations/1/users.json')
        .with(body: { user: { uid: '123467890' }, access_token: '1' }.to_json))
        .to have_been_made
    end
    it 'returns a User' do
      user = client.provision_user(uid: '123467890')
      expect(user).to be_a Validic::User
      expect(user.uid).to eq '123467890'
    end
  end
end
