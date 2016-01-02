module ApplicationHelper

  def description_meta_tag
    return "" if @site.description.blank?

    tag(:meta, name: "description", content: @site.description)
  end

  def link_to_home_page text = nil, options = {}, &block
    options = text if block_given?
    options = page_link_options(@site.home_page).merge(options)

    if block_given?
      link_to home_page_path, options, &block
    else
      link_to text, home_page_path, options
    end
  end

  def nav_link_to nav_link
    link_to nav_link.text, nav_link.url, page_link_options(nav_link.page)
  end

  def page_link_options page
    options = {}
    return options if page.nil?

    if changing_layouts?(page)
      options[:data] = { no_turbolink: true } if page.has_styles_or_scripts?
    else
      options[:remote] = true
    end

    options
  end

  def changing_layouts? target_page
    return true if current_page.nil?

    current_page.blank_layout? != target_page.blank_layout?
  end

  def current_page
    return @current_page if defined?(@current_page)
    @current_page = admin_page? ? nil : @page
  end

  def admin_page?
    request.path.starts_with?("/admin")
  end

  def pagination_links collection, options = {}
    options.reverse_merge!(remote: true, class: "btn-main")

    links = link_to_previous_page(collection, "#{fa_icon("caret-left")} Prev".html_safe,
      options.dup) || "".html_safe
    links += link_to_next_page(collection, "Next #{fa_icon("caret-right")}".html_safe,
      options.dup) || ""
  end

  def formatted_tweet_time tweet
    time_with_zone = tweet.posted_at.in_time_zone("Central Time (US & Canada)")
    time_in_words = time_ago_in_words(time_with_zone).sub(/\Aabout /, "")
    "#{time_in_words} ago"
  end

  def session_link
    options = { class: "session" }

    if user_signed_in?
      options.merge!(method: :delete)
      link_to "Sign Out", sign_out_path, options
    else
      link_to "Sign In", sign_in_path, options
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