module ApplicationHelper

  def flash_class(flash_type)
    case flash_type
    when :error
      "alert-danger"
    when :info
      "alert-info"
    when :notice
      "alert-success"
    when :warning
      "alert-warning"
    else
      "alert-info"
    end
  end

  def events_chart_data(domain, days_ago)
    start = days_ago.days.ago
    events = domain.events
    distinct_events = events.distinct(:name)
    data = distinct_events.map do |name|
      {
        name: name,
        value: events.where(:name => name, :created_on.gte => start).count
      }
    end
    data.to_json
  end
  
end
