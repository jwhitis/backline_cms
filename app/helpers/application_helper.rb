module ApplicationHelper

  def nav_link_to nav_link
    options = {}

    if target_page = nav_link.page
      if current_page_is_admin?
        options[:data] = { no_turbolink: true } if target_page.javascript.present?
      else
        options[:remote] = true
      end
    end

    link_to nav_link.text, nav_link.url, options
  end

  def current_page_is_admin?
    @current_page_is_admin ||= request.path.starts_with?("/admin")
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

  def flash_modal_classes
    flash.keys.map { |name| "modal-#{name}" }.join(" ")
  end

  def flash_modal_icon
    icon = flash.keys.include?("alert") ? "exclamation" : "check"
    fa_stacked_icon(icon, base: "circle-thin")
  end

end