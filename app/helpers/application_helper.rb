module ApplicationHelper

  def description_meta_tag site
    return "" if site.description.blank?

    tag(:meta, name: "description", content: site.description)
  end

  def nav_link_to nav_link
    link_to nav_link.text, nav_link.url, nav_link_options(nav_link)
  end

  def nav_link_options nav_link
    options = {}
    return options unless page = nav_link.page

    if changing_layouts?(page)
      options[:data] = { no_turbolink: true } if page.has_styles_or_scripts?
    else
      options[:remote] = true
    end

    options
  end

  def changing_layouts? page
    current_page_is_admin? || page.blank_layout?
  end

  def current_page_is_admin?
    @current_page_is_admin ||= request.path.starts_with?("/admin")
  end

  def pagination_links collection, options = {}
    options = { remote: true }.merge(options)

    links = link_to_previous_page(collection, "#{fa_icon("caret-left")} PREV".html_safe,
      options) || "".html_safe
    links += link_to_next_page(collection, "NEXT #{fa_icon("caret-right")}".html_safe,
      options) || ""
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