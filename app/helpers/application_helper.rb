module ApplicationHelper

  def formatted_time time
    time_with_zone = time.in_time_zone("Central Time (US & Canada)")
    time_in_words = time_ago_in_words(time_with_zone).sub(/\Aabout /, "")
    "#{time_in_words} ago"
  end

  def admin_signed_in?
    session[:admin]
  end

end
