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
    it "should create new fitness record" do
      @new_fitness = client.create_fitness({authentication_token: "mqwpDx8RYcmSFBJDmy3J",
                                            access_token: "DEMO_KEY",
                                            timestamp: "2013-03-10 07:12:16 -05:00",
                                            primary_type: "Running",
                                            intensity: "medium",
                                            start_time: "2013-03-09 13:55:36 -05:00",
                                            total_distance: 5149.9,
                                            duration: 1959.90,
                                            source: "Sample App"})

      @new_fitness.fitness.timestamp.should eq "2013-03-10 07:12:16 -05:00"
      @new_fitness.fitness.type.should eq "Running"
      @new_fitness.fitness.intensity.should eq "medium"
      @new_fitness.fitness.start_time.should eq "2013-03-09 13:55:36 -05:00"
      @new_fitness.fitness.total_distance.should eq 5149.9
      @new_fitness.fitness.duration.should eq 1959.90
      @new_fitness.fitness.source.should eq "Sample App"
    end
  end

  context "#get_fitnesses by organization" do
    before do
      @fitness = client.get_fitnesses({organization_id: "519e24e16a7e0cc7ef00002b", access_token: "ENTERPRISE_KEY"})
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
      @fitness = client.get_fitnesses({user_id: "519e24e16a7e0cc7ef00002c"})
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
