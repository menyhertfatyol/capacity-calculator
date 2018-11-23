require 'date'

class CapacityCalculator

  def calculate(pages_per_hour, date)
    iso_date = DateTime.parse date
    return "The press is open between 9AM - 5PM on weekdays" if (iso_date.hour < 9 or iso_date.hour > 17) or (iso_date.saturday? or iso_date.sunday?)

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

  def is_last_friday?(date)
    date.friday? && (date + 7).month == (date.month + 1)
  end

  def is_first_friday?(date)
    date.friday? && (date - 7).month == (date.month - 1)
  end
end