module DateHelper
  def beginning_of_next_month
    today.beginning_of_month.next_month
  end

  def end_of_next_month
    today.end_of_month.next_month
  end

  def today
    Time.zone.today
  end

  def days_in_this_month
    Time.days_in_month(today.month)
  end

  def days_in_this_year
    Time.days_in_year(today.month)
  end

  def distance_of_time_in_days_from(unit, distance)
    distance_of_time_in(unit, distance).yield_self { |d| round_to_days(unit, d) }
  end

  def distance_of_time_in(unit, distance)
    raise ArgumentError, "#{unit.inspect} is not supported as unit" unless 1.respond_to? unit

    distance_in_unit = distance / 1.send(unit)
  end

  def round_to_days(unit, distance)
    case unit
    when :months then (distance / days_in_this_month * 1.0).ceil * days_in_this_month
    when :year then (distance / days_in_this_year * 1.0).ceil * days_in_this_year
    end
  end

  def days_since_beginning_of_month(date)
    date - date.beginning_of_month + 1
  end

  def days_until_end_of_month(date)
    date.end_of_month - date + 1
  end

  def each_month_between(start_date, end_date)
    date = start_date

    while date < end_date
      month = date.month
      days_elapsed = days_since_beginning_of_month(date)
      days_left = days_until_end_of_month(date)

      yield(month, days_elapsed, days_left)
      date = date.advance(months: 1)
    end
  end
end

