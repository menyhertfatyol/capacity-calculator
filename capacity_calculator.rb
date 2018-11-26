require 'date'

class CapacityCalculator

  def calculate(pages_per_hour, date)
    iso_date = DateTime.parse date
    return 0 if (iso_date.hour < 9 or iso_date.hour > 17) or (iso_date.saturday? or iso_date.sunday?)

    if is_maintenance_day? iso_date
      self.pages_on_maintenance_day(pages_per_hour, iso_date.hour)
    else
      self.pages_by_hour(pages_per_hour, iso_date.hour)
    end

  end

  def pages_by_hour(pages, hour)
    case
    when hour >= 9 && hour < 10
      pages * 0.25
    when hour >= 10 && hour < 11
      pages * 0.5
    when hour >= 11 && hour < 12
      pages * 0.75
    else
      pages
    end
  end

  def pages_on_maintenance_day(pages, hour)
    case
    when hour >= 9 && hour < 10
      pages * 0.25
    when hour >= 10 && hour < 11
      pages * 0.5
    when hour >= 11 && hour < 13
      0
    when hour >= 13 && hour < 14
      pages * 0.25
    when hour >= 14 && hour < 15
      pages * 0.5
    when hour >= 15 && hour < 16
      pages * 0.75
    else
      pages
    end
  end

  def is_maintenance_day?(date)
    is_first_or_last_friday_of_the_month?("first", date) || is_first_or_last_friday_of_the_month?("last", date)
  end

  def is_first_or_last_friday_of_the_month?(first_or_last, date)
    puts "First parameter should be either 'first' or 'last'!" unless ["first", "last"].include? first_or_last

    case first_or_last
    when "first"
      operator = "-"
    else
      operator = "+"
    end

    date.friday? && (date.public_send operator, 7).month == (date.month.public_send operator, 1)
  end
end