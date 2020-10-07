# frozen_string_literal: true

module ApplicationHelper
  def query_params
    return {} unless params[:q]

    params[:q].to_enum.to_h.symbolize_keys
  end

  def current_query_url(params = {})
    url_for(
      controller: controller_name,
      action: action_name,
      anchor: params.delete(:anchor),
      params: { q: query_params.merge(params) }
    )
  end

  def distance_of_time(time)
    if time > Time.now
      "in #{distance_of_time_in_words_to_now time}"
    else
      "#{distance_of_time_in_words_to_now time} ago"
    end
  end

  def format_date(date)
    return unless date

    date.strftime("%b #{date.day.ordinalize} %Y")
  end

  def distance_of_time_in(unit, distance)
    raise ArgumentError, "#{unit.inspect} is not supported as unit" unless 1.respond_to? unit

    (distance / 1.send(unit)).round
  end

  def markers_for(records)
    records.map(&:coordinates).to_json
  end
end
