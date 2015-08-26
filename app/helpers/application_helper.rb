module ApplicationHelper

  def flash_modal_classes
    flash.keys.map { |name| "modal-#{name}" }.join(" ")
  end

  def flash_modal_icon
    icon = flash.keys.include?("alert") ? "exclamation" : "check"
    fa_stacked_icon(icon, base: "circle-thin")
  end

  def formatted_tweet_time tweet
    time_with_zone = tweet.posted_at.in_time_zone("Central Time (US & Canada)")
    time_in_words = time_ago_in_words(time_with_zone).sub(/\Aabout /, "")
    "#{time_in_words} ago"
  end

  def admin_link
    if admin_signed_in?
      link_to "SIGN OUT", admin_sign_out_path, method: :delete
    else
      link_to "SIGN IN", admin_sign_in_path
    end
  end

end