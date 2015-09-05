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

end