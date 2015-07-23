describe Validic::Summary do

  describe "#initialize" do
    it "does not raise error with nil sum_hash" do
      expect { Validic::Summary.new(nil) }.to_not raise_error
    end

    it "sets all attributes to nil if initialized with nil sum_hash" do
      summary = Validic::Summary.new(nil)

      %w(timestamp start_date end_date offset message results limit previous next status).each do |message|
        expect(summary.send(message)).to be_nil
      end
    end
  end
end
