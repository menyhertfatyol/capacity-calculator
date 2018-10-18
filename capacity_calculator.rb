require 'date'

class CapacityCalculator

  def calculate(pages_per_hour, date)
    iso_date = DateTime.parse date
    return "The press is open between 9AM - 5PM on weekdays" if iso_date.hour < 9 or iso_date.hour > 17

    self.pages_by_hour(pages_per_hour, iso_date.hour)

  end

  def pages_by_hour(pages, hour)
    case hour
    when 9
      pages * 0.25
    when 10
      pages * 0.5
    when 11
      pages * 0.75
    else
      pages
    end
  end
end