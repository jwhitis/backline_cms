module ApplicationHelper

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

  def photo_caption photo
    "<div class='photo-caption'>#{photo.caption}</div>"
  end

  def file_btn checked = false, text = "Choose File"
    btn_classes = ["btn-white", "file-btn"]
    btn_classes << "checked" if checked

    content_tag(:button, type: "button", class: btn_classes.join(" ")) do
      text.html_safe + fa_icon("check")
    end
  end

  def submit_btn text = "Save"
    content_tag(:button, type: "submit", class: "btn-blue submit-btn") do
      text.html_safe + fa_icon("spinner spin")
    end
  end

end
