# encoding: utf-8
require 'spec_helper'

describe Validic::Client do

  let(:client) { Validic::Client.new }

  it "creates a Faraday::Connection" do
    client.connection.should be_kind_of Faraday::Connection
  end

  context "#latest" do
    it "#fitness", vcr: true do
      latest_fitness = client.latest(:fitness)
      latest_fitness.summary.should_not be_nil
    end

    it "#sleep", vcr: true do
      latest_sleep = client.latest(:sleep)
      latest_sleep.summary.should_not be_nil
    end

    it "#routine", vcr: true do
      latest_routine = client.latest(:routine)
      latest_routine.summary.should_not be_nil
    end

    it "#weight", vcr: true do
      latest_weight = client.latest(:weight)
      latest_weight.summary.should_not be_nil
    end

    it "#biometrics", vcr: true do
      latest_biometrics = client.latest(:biometrics)
      latest_biometrics.summary.should_not be_nil
    end

    it "#nutrition", vcr: true do
      latest_nutrition = client.latest(:nutrition)
      latest_nutrition.summary.should_not be_nil
    end

    it "#tobacco_cessation", vcr: true do
      latest_tobacco_cessation = client.latest(:tobacco_cessation)
      latest_tobacco_cessation.summary.should_not be_nil
    end
  end

end
