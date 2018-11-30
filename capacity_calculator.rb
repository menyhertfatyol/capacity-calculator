# todo: lookup strategy pattern
require 'date'

class CapacityCalculator

  def calculate(pages_per_hour, date)
    iso_date = DateTime.parse date
    raise ArgumentError.new("Press is open only on weekdays from 9 to 17") if is_out_of_work_time?(iso_date)

    if is_maintenance_day? iso_date
      efficiency_on_maintenance_day(iso_date.hour) * pages_per_hour
    else
      efficiency(iso_date.hour) * pages_per_hour
    end

  end

  private

  def is_out_of_work_time?(iso_date)
    (iso_date.hour < 9 or iso_date.hour > 17) or (iso_date.saturday? or iso_date.sunday?)
  end

  def efficiency(hour)
    case hour
    when 9...10
      0.25
    when 10...11
      0.5
    when 11...12
      0.75
    else
      1
    end
  end

  def efficiency_on_maintenance_day(hour)
    case hour
    when 9...10
      0.25
    when 10...11
      0.5
    when 11...13
      0
    when 13...14
      0.25
    when 14...15
      0.5
    when 15...16
      0.75
    else
      1
    end
  end

  def is_maintenance_day?(date)
    is_first_or_last_friday_of_the_month?("first", date) || is_first_or_last_friday_of_the_month?("last", date)
  end

  def is_first_or_last_friday_of_the_month?(first_or_last, date)
    return "First parameter should be either 'first' or 'last'!" unless %w(first last).include? first_or_last

    case first_or_last
    when "first"
      operator = "-"
    else
      operator = "+"
    end

    date.friday? && (date.public_send operator, 7).month == (date.month.public_send operator, 1)
  end
end