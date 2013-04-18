# encoding: utf-8
require 'spec_helper'

describe Validic::Client do

  it "creates a Faraday::Connection" do
    client = Validic::Client.new
    client.connection.should be_kind_of Faraday::Connection
  end

end
