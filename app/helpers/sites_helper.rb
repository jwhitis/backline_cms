module SitesHelper

  def site_style_tag
    css = SiteCSSCompiler.new(@site).css
    return "" if css.blank?

    content_tag(:style, css.html_safe, id: "site-css")
  end

end