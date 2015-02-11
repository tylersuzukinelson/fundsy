module ApplicationHelper
  def formatted_date(date)
    date.strftime("%Y-%m-%d") if date
  end
end
