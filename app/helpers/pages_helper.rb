module PagesHelper

  def page_style_tag page
    return "" if page.css.blank?

    content_tag(:style, page.css, id: "page-css")
  end

end