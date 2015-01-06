# encoding: utf-8
require 'spec_helper'

describe Validic::Fitness do

  let(:client) { Validic::Client.new }

  context "#get_fitnesses" do
    before do
      @fitness = client.get_fitnesses({})
    end

    it "returns JSON response of Validic::Fitness", vcr: true do
      @fitness.should_not be_nil
    end

    it "status 200" do
      @fitness.summary.status.should == 200
    end

    it "has summary node" do
      @fitness.summary.should_not be_nil
    end
  end

  context "#create_fitness" do
    it "should create new fitness record", vcr: true do
      @new_fitness = client.create_fitness(ENV['PARTNER_USER_ID'], organization_id: ENV['PARTNER_ORG_ID'], access_token: ENV['PARTNER_ACCESS_TOKEN'], activity_id: 'fitness_1', timestamp: "2015-01-06T16:14:17+00:00", type: "Running")
      @new_fitness.should_not be_nil
      @new_fitness.fitness.timestamp.should eq "2015-01-06T16:14:17+00:00"
      @new_fitness.fitness.activity_id.should eq 'fitness_1'
      @new_fitness.fitness.source.should eq "healthy_yet"
    end
  end

  context "#get_fitnesses by organization" do
    before do
      @fitness = client.get_fitnesses({organization_id: "51aca5a06dedda916400002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Fitness", vcr: true do
      @fitness.should_not be_nil
    end

    it "status 200" do
      @fitness.summary.status.should == 200
    end

    it "has summary node" do
      @fitness.summary.should_not be_nil
    end
  end

  context "#get_fitnesses by user" do
    before do
      @fitness = client.get_fitnesses({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::Fitness", vcr: true do
      @fitness.should_not be_nil
    end

    it "status 200" do
      @fitness.summary.status.should == 200
    end

    it "has summary node" do
      @fitness.summary.should_not be_nil
    end
  end

end
