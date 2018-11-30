require_relative 'capacity_calculator'

RSpec.describe CapacityCalculator do
  describe '#calculate' do

    context "On a usual workday" do
      cases = [
          {description: "when working on full capacity", pages: 1000, date: "2018-06-11 16:00", result: 1000},
          {description: "when working on 25% from the first hour", pages: 2000, date: "2018-06-12 09:00", result: 500},
          {description: "when working on 50% from the secound hour", pages: 3000, date: "2018-10-18 10:00", result: 1500},
          {description: "when working on 75% from the third hour", pages: 4000, date: "2018-10-18 11:00", result: 3000},
      ]

      cases.each do |test_case|
        it "returns #{test_case[:result]} out of #{test_case[:pages]} pages #{test_case[:description]}" do
          expect(CapacityCalculator.new.calculate(test_case[:pages], test_case[:date])).to eq(test_case[:result])
        end
      end
    end

    context "On maintenance day" do
      cases = [
          {description: "works on 25% in the first hour of the day", pages: 2000, date: "2018-11-02 09:00", result: 500},
          {description: "not printing at all during maintenance", pages: 2000, date: "2018-11-30 12:59", result: 0},
          {description: "restarts from 25% after maintenance", pages: 2000, date: "2018-11-30 13:00", result: 500},
          {description: "works on 50% from 2nd hour after maintenance", pages: 2000, date: "2018-11-30 14:00", result: 1000},
          {description: "works on 75% from 3nd hour after maintenance", pages: 2000, date: "2018-11-30 15:00", result: 1500},
          {description: "works on full capacity after maintenance and warmup", pages: 2000, date: "2018-11-30 16:00", result: 2000},
      ]

      cases.each do |test_case|
        it "returns #{test_case[:result]} out of #{test_case[:pages]} pages, #{test_case[:description]}" do
          expect(CapacityCalculator.new.calculate(test_case[:pages], test_case[:date])).to eq(test_case[:result])
        end
      end
    end

    context "When press is not open" do
      it 'returns an argument error' do
        expect { CapacityCalculator.new.calculate(1000, "2018-10-18 07:00") }.to raise_error(ArgumentError, "Press is open only on weekdays from 9 to 17")
      end
    end
  end

  xdescribe '#is_first_or_last_friday_of_the_month?' do
    cases = [
        {description: "true if date is Friday and is the last Friday of the month", first_or_last: "last", date: "2018-10-26", expectation: true},
        {description: "false if day is in the last week but not Friday", first_or_last: "last", date: "2018-10-25", expectation: false},
        {description: "false if Friday is the one before the last Friday", first_or_last: "last", date: "2018-10-18", expectation: false},
        {description: "true if date is Friday and is the first Friday of the month", first_or_last: "first", date: "2018-10-05", expectation: true},
        {description: "false if day is in the first week but not Friday", first_or_last: "first", date: "2018-10-04", expectation: false},
        {description: "false is Friday is the second Friday of the month", first_or_last: "first", date: "2018-10-12", expectation: false},
    ]

    cases.each do |test_case|

      it "returns #{test_case[:description]}" do
        expect(CapacityCalculator.new.is_first_or_last_friday_of_the_month? test_case[:first_or_last], Date.parse(test_case[:date])).to be test_case[:expectation]
      end
    end
  end
end
