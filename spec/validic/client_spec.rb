# encoding: utf-8
require 'spec_helper'

describe Validic::Client do
  let(:client) { Validic::Client.new }

  describe '#connection' do
    it 'returns a Faraday::Connection object' do
      expect(client.connection).to be_kind_of Faraday::Connection
    end

    it 'has SSL enabled' do
      expect(client.connection.ssl.verify).to be true
    end
  end
end
