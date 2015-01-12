# encoding: utf-8
require 'spec_helper'

describe Validic do
  describe '.configure' do
    context 'when no block given' do
      it 'throws an error' do
        expect{ Validic.configure }.to raise_error
      end
    end

    context 'with block given' do
      it 'sets the attributes correctly' do
        Validic.configure do |c|
          c.api_url = 'https://validic.com/api'
          c.api_version = 'v2'
          c.access_token = '123'
          c.organization_id = 'abc'
        end

        expect(Validic.api_url).to eq 'https://validic.com/api'
        expect(Validic.api_version).to eq 'v2'
        expect(Validic.access_token).to eq '123'
        expect(Validic.organization_id).to eq 'abc'
      end
    end
  end
end
