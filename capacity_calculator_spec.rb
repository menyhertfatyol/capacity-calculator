require_relative 'capacity_calculator'

RSpec.describe CapacityCalculator do
  describe '#calculate' do
    context "When working on full capacity" do

      cases = [
          {description: "", pages: 1000, date: "2018-06-11 16:00", result: 1000}
      ]

      it 'returns the maximum amount of pages per hour' do
        expect(CapacityCalculator.new.calculate(1000, "2018-06-11 16:00")).to eq(1000)
      end
    end

    context "When printers are warming up" do
      it 'works on 25% capacity in the first hour' do
        expect(CapacityCalculator.new.calculate(2000, "2018-06-12 09:00")).to eq(500)
      end

      it 'works on 50% capacity from the secound hour' do
        expect(CapacityCalculator.new.calculate(3000, "2018-10-18 10:00")).to eq(1500)
      end

      it 'works on 75% capacity from the third hour' do
        expect(CapacityCalculator.new.calculate(4000, "2018-10-18 11:00")).to eq(3000)
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