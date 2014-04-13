module ApplicationHelper

  def formatted_time time
    time_with_zone = time.in_time_zone("Central Time (US & Canada)")
    format_string = time_with_zone.to_date == Date.today ? "%l:%M%P" : "%-m/%-d/%y"
    time_with_zone.strftime(format_string)
  end

  def admin_signed_in?
    session[:admin]
  end

end
