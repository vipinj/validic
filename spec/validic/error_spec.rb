require 'spec_helper'

describe Validic::Error do
  let(:client) { Validic::Client.new }

  context 'not found' do
    %w(weight nutrition biometrics diabetes tobacco_cessation routine fitness weight).each do |activity|
      before do
        stub_get("/organizations/1/users/0/#{activity}.json")
          .with(query: { access_token: '1' })
          .to_return(status: 404, body: fixture('not_found.json'), headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'raises a NotFound error' do
        expect { client.send("get_#{activity}", user_id: '0') }.to raise_error(Validic::Error::NotFound)
      end
    end
  end
end
