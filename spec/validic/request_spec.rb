require 'spec_helper'

describe Validic::Request do
  let(:client) { Validic::Client.new }

  context "#latest" do
    context "for organization" do
      it "#diabetes", vcr: true do
        latest_diabetes = client.latest(:diabetes)
        expect(latest_diabetes.summary).not_to be_nil
      end

      it "#fitness", vcr: true do
        latest_fitness = client.latest(:fitness)
        expect(latest_fitness.summary).not_to be_nil
      end

      it "#sleep", vcr: true do
        latest_sleep = client.latest(:sleep)
        expect(latest_sleep.summary).not_to be_nil
      end

      it "#routine", vcr: true do
        latest_routine = client.latest(:routine)
        expect(latest_routine.summary).not_to be_nil
      end

      it "#weight", vcr: true do
        latest_weight = client.latest(:weight)
        expect(latest_weight.summary).not_to be_nil
      end

      it "#biometrics", vcr: true do
        latest_biometrics = client.latest(:biometrics)
        expect(latest_biometrics.summary).not_to be_nil
      end

      it "#nutrition", vcr: true do
        latest_nutrition = client.latest(:nutrition)
        expect(latest_nutrition.summary).not_to be_nil
      end

      it "#tobacco_cessation", vcr: true do
        latest_tobacco_cessation = client.latest(:tobacco_cessation)
        expect(latest_tobacco_cessation.summary).not_to be_nil
      end
    end

    context "for user" do
      it "#diabetes", vcr: true do
        latest_diabetes = client.latest(:diabetes, user_id: ENV['TEST_USER_ID'])
        expect(latest_diabetes.summary).not_to be_nil
      end

      it "#fitness", vcr: true do
        latest_fitness = client.latest(:fitness, user_id: ENV['TEST_USER_ID'])
        expect(latest_fitness.summary).not_to be_nil
      end

      it "#sleep", vcr: true do
        latest_sleep = client.latest(:sleep, user_id: ENV['TEST_USER_ID'])
        expect(latest_sleep.summary).not_to be_nil
      end

      it "#routine", vcr: true do
        latest_routine = client.latest(:routine, user_id: ENV['TEST_USER_ID'])
        expect(latest_routine.summary).not_to be_nil
      end

      it "#weight", vcr: true do
        latest_weight = client.latest(:weight, user_id: ENV['TEST_USER_ID'])
        expect(latest_weight.summary).not_to be_nil
      end

      it "#biometrics", vcr: true do
        latest_biometrics = client.latest(:biometrics, user_id: ENV['TEST_USER_ID'])
        expect(latest_biometrics.summary).not_to be_nil
      end

      it "#nutrition", vcr: true do
        latest_nutrition = client.latest(:nutrition, user_id: ENV['TEST_USER_ID'])
        expect(latest_nutrition.summary).not_to be_nil
      end

      it "#tobacco_cessation", vcr: true do
        latest_tobacco_cessation = client.latest(:tobacco_cessation, user_id: ENV['TEST_USER_ID'])
        expect(latest_tobacco_cessation.summary).not_to be_nil
      end
    end
  end
end
