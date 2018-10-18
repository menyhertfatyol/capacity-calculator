require_relative 'capacity_calculator'

RSpec.describe CapacityCalculator do
  describe '#calculate' do
    context "When working on full capacity" do

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
end