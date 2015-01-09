# encoding: utf-8
require 'spec_helper'

describe Validic::Fitness do

  let(:client) { Validic::Client.new }

  context "#get_fitnesses" do
    before do
      @fitness = client.get_fitnesses({})
    end

    it "returns JSON response of Validic::Fitness", vcr: true do
      expect(@fitness).not_to be_nil
    end

    it "status 200" do
      expect(@fitness.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@fitness.summary).not_to be_nil
    end
  end

  context "#get_fitnesses by organization" do
    before do
      @fitness = client.get_fitnesses({organization_id: "51aca5a06dedda916400002b", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::Fitness", vcr: true do
      expect(@fitness).not_to be_nil
    end

    it "status 200" do
      expect(@fitness.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@fitness.summary).not_to be_nil
    end
  end

  context "#get_fitnesses by user" do
    before do
      @fitness = client.get_fitnesses({user_id: ENV['TEST_USER_ID']})
    end

    it "returns JSON response of Validic::Fitness", vcr: true do
      expect(@fitness).not_to be_nil
    end

    it "status 200" do
      expect(@fitness.summary.status).to eq(200)
    end

    it "has summary node" do
      expect(@fitness.summary).not_to be_nil
    end
  end

  context "Validic Connect" do
    before do
      @connect = Validic::Client.new(organization_id: ENV['PARTNER_ORG_ID'],
                                     access_token: ENV['PARTNER_ACCESS_TOKEN'],
                                     api_url: 'https://api.validic.com',
                                     api_version: 'v1')
    end

    context "#create_fitness" do
      it "should create new fitness record", vcr: true do
        @new_fitness = @connect.create_fitness(ENV['PARTNER_USER_ID'], "fitnessez")
        expect(@new_fitness).not_to be_nil
        expect(@new_fitness.fitness.activity_id).to eq "fitnessez"
        expect(@new_fitness.fitness.source).to eq "healthy_yet"
      end
    end

    context "#update_fitness" do
      it "should update fitness record", vcr: true do
        @update_fitness = @connect.update_fitness(ENV['PARTNER_USER_ID'], "54aeedef84626b378100025d", calories: 10.0)
        expect(@update_fitness).not_to be_nil
        expect(@update_fitness.fitness.calories).to eq 10.0
        expect(@update_fitness.fitness.source).to eq "healthy_yet"
      end
    end

    context "#delete_fitness" do
      it "should delete fitness record", vcr: true do
        @delete_fitness = @connect.delete_fitness(ENV['PARTNER_USER_ID'], "54aeedef84626b378100025d")
        expect(@delete_fitness.code).to eq 200
      end
    end
  end

end
