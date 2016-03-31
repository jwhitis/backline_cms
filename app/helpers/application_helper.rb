module ApplicationHelper

  def description_meta_tag
    return "" if @site.description.blank?

    tag(:meta, name: "description", content: @site.description)
  end

  def navbar_tag &block
    options = {
      class: "navbar",
      role: "navigation",
      data: {
        initial_background: @site.nav_background_color,
        solid_background: @site.solid_nav_background_color
      }
    }

    content_tag(:nav, options, &block)
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

  def banner_link_to
    options = page_link_options(@site.banner_link.page)
    options.merge!(id: "banner-link", class: "hidden-xs")

    link_to banner_tag, @site.banner_link.url, options
  end

  def banner_tag
    options = { id: "banner" }
    options[:class] = "full-screen" if @site.banner.full_screen?

    content_tag(:div, nil, options)
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

    content_tag(:div, class: "pagination-links") do
      link_to_previous_page(collection, "#{fa_icon("caret-left")} Prev".html_safe,
        options.dup).to_s.html_safe +
      link_to_next_page(collection, "Next #{fa_icon("caret-right")}".html_safe, options.dup)
    end
  end

  def formatted_tweet_time tweet
    time_with_zone = tweet.posted_at.in_time_zone("Central Time (US & Canada)")
    time_in_words = time_ago_in_words(time_with_zone).sub(/\Aabout /, "")
    "#{time_in_words} ago"
  end

  def footer_text
    if admin_page?
      "Powered by Backline CMS"
    else
      "&copy; #{Time.now.year} #{@site.title}".html_safe
    end
  end

  def session_link
    options = { class: "session" }

    if user_signed_in?
      options.merge!(method: :delete)
      link_to "Sign Out", sign_out_path, options
    else
      options.merge!(remote: true)
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