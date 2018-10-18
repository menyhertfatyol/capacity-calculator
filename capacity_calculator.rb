require 'date'

class CapacityCalculator
  def self.calculate(pages_per_hour, date)
    iso_date = DateTime.parse date
    return "The press is open between 9AM - 5PM on weekdays" if iso_date.hour < 9 or iso_date.hour > 17

    case iso_date.hour
    when 9
      pages_per_hour * 0.25
    when 10
      pages_per_hour * 0.5
    when 11
      pages_per_hour * 0.75
    else
      pages_per_hour
    end
  end
end