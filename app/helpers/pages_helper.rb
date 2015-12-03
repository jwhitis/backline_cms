module PagesHelper

  def page_style_tag page
    return "" if page.css.blank?

    content_tag(:style, page.css.html_safe, id: "page-css")
  end

  def page_script_tag page
    return "" if page.javascript.blank?

    javascript = "$(document).ready(function() { #{page.javascript} });"
    content_tag(:script, javascript.html_safe, id: "page-javascript")
  end

  def default_page_info_box page
    feature_name = page.feature.name.titleize
    settings_link = link_to "Settings", "javascript:void(0)", class: "settings"

    info_box("You can hide this page by disabling the #{feature_name} feature on the #{settings_link} page.")
  end

end