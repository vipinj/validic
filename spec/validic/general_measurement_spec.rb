# encoding: utf-8
require 'spec_helper'

describe Validic::GeneralMeasurement do

  let(:client) { Validic::Client.new }

  context "#get_general_measurements" do
    before do
      @general_measurement = client.get_general_measurements({})
    end

    it "returns JSON response of Validic::GeneralMeasurement", vcr: true do
      @general_measurement.should_not be_nil
    end

    it "status 200" do
      @general_measurement.summary.status.should == 200 
    end

    it "has summary node" do
      @general_measurement.summary.should_not be_nil
    end
  end

  context "#create_general_measurement" do
    it "should create new general_measurement record" do
      @new_general_measurement = client.create_general_measurement({timestamp: "2013-05-16 07:12:16 -05:00",
                                                                    blood_calcium: 7.6,
                                                                    blood_chromium: 1.75,
                                                                    blood_folic_acid: 4.4,
                                                                    blood_magnesium: 1.24,
                                                                    blood_potassium: 1.9,
                                                                    blood_sodium: 122.1,
                                                                    blood_vitamin_b12: 600,
                                                                    blood_zinc: 120,
                                                                    creatine_kinase: 75,
                                                                    crp: 1,
                                                                    diastolic: 72,
                                                                    ferritin: 175,
                                                                    hdl: 41,
                                                                    hscrp: 0.91,
                                                                    il6: 0.94,
                                                                    resting_heartrate: 75,
                                                                    systolic: 115,
                                                                    testosterone: 255,
                                                                    total_cholesterol: 150,
                                                                    tsh: 0.8,
                                                                    uric_acid: 7.4,
                                                                    vitamin_d: 55.3,
                                                                    white_cell_count: 7685.34,
                                                                    source: "Sample App"})
      @new_general_measurement.should_not be_nil
      @new_general_measurement.general_measurement.timestamp.should eq "2013-05-16 07:12:16 -05:00"
      @new_general_measurement.general_measurement.blood_calcium.should eq 7.6
      @new_general_measurement.general_measurement.blood_chromium.should eq 1.75
      @new_general_measurement.general_measurement.blood_folic_acid.should eq 4.4
      @new_general_measurement.general_measurement.blood_magnesium.should eq 1.24
      @new_general_measurement.general_measurement.blood_potassium.should eq 1.9
      @new_general_measurement.general_measurement.blood_sodium.should eq 122.1
      @new_general_measurement.general_measurement.blood_vitamin_b12.should eq 600.0
      @new_general_measurement.general_measurement.blood_zinc.should eq 120.0
      @new_general_measurement.general_measurement.creatine_kinase.should eq 75.0
      @new_general_measurement.general_measurement.crp.should eq 1.0
      @new_general_measurement.general_measurement.diastolic.should eq 72.0
      @new_general_measurement.general_measurement.ferritin.should eq 175.0
      @new_general_measurement.general_measurement.hdl.should eq 41.0
      @new_general_measurement.general_measurement.hscrp.should eq 0.91
      @new_general_measurement.general_measurement.il6.should eq 0.94
      @new_general_measurement.general_measurement.resting_heartrate.should eq 75.0
      @new_general_measurement.general_measurement.systolic.should eq 115.0
      @new_general_measurement.general_measurement.testosterone.should eq 255.0
      @new_general_measurement.general_measurement.total_cholesterol.should eq 150.0
      @new_general_measurement.general_measurement.tsh.should eq 0.8
      @new_general_measurement.general_measurement.uric_acid.should eq 7.4
      @new_general_measurement.general_measurement.vitamin_d.should eq 55.3
      @new_general_measurement.general_measurement.white_cell_count.should eq 7685.34
      @new_general_measurement.general_measurement.source.should eq "Sample App"
    end
  end

  context "#get_general_measurements by organization" do
    before do
      @general_measurement = client.get_general_measurements({org_id: "51945d536a7e0cb3db000029", access_token: "ENTERPRISE_KEY"})
    end

    it "returns JSON response of Validic::GeneralMeasurement", vcr: true do
      @general_measurement.should_not be_nil
    end

    it "status 200" do
      @general_measurement.summary.status.should == 200 
    end

    it "has summary node" do
      @general_measurement.summary.should_not be_nil
    end
  end

end
