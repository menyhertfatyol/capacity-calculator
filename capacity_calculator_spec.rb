require_relative 'capacity_calculator'

RSpec.describe CapacityCalculator do
  describe '#calculate' do

    context "On a usual workday" do
      cases = [
          {description: "when working on full capacity", pages: 1000, date: "2018-06-11 16:00", result: 1000},
          {description: "when working on 25% from the first hour", pages: 2000, date: "2018-06-12 09:00", result: 500},
          {description: "when working on 50% from the secound hour", pages: 3000, date: "2018-10-18 10:00", result: 1500},
          {description: "when working on 75% from the third hour", pages: 4000, date: "2018-10-18 11:00", result: 3000},
          {description: "When press is not open", pages: 4000, date: "2018-10-18 11:00", result: 3000},
      ]

      cases.each do |test_case|
        it "returns #{test_case[:result]} out of #{test_case[:pages]} pages #{test_case[:description]}" do
          expect(CapacityCalculator.new.calculate(test_case[:pages], test_case[:date])).to eq(test_case[:result])
        end
      end
    end

    context "When press is not open" do
      it 'returns a message about the opening hours' do
        expect(CapacityCalculator.new.calculate(1000, "2018-10-18 07:00")).to eq("The press is open between 9AM - 5PM on weekdays")
      end
    end
  end

  describe '#is_last_friday?' do
    it 'returns true if date is fryday and is the last friday of the month' do
      expect(CapacityCalculator.new.is_last_friday?(Date.parse "2018-10-26")).to be_truthy
    end

    it 'returns false if day is in the last week but not friday' do
      expect(CapacityCalculator.new.is_last_friday?(Date.parse "2018-10-25")).to be_falsey
    end

    it 'returns false is friday is one before the last friday' do
      expect(CapacityCalculator.new.is_last_friday?(Date.parse "2018-10-18")).to be_falsey
    end
  end

  describe '#is_first_friday?' do
    it 'returns true if date is fryday and is the first friday of the month' do
      expect(CapacityCalculator.new.is_first_friday?(Date.parse "2018-10-05")).to be_truthy
    end

    it 'returns false if day is in the first week but not friday' do
      expect(CapacityCalculator.new.is_first_friday?(Date.parse "2018-10-04")).to be_falsey
    end

    it 'returns false is friday is one after the last friday' do
      expect(CapacityCalculator.new.is_first_friday?(Date.parse "2018-10-12")).to be_falsey
    end
  end
end