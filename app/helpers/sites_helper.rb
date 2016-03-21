module SitesHelper

  def site_style_tag
    css = SiteCSSCompiler.new(@site).css
    return "" if css.blank?

    content_tag(:style, css.html_safe, id: "site-css")
  end

  def view_site_link site
    link_to fa_icon("desktop"), root_url(subdomain: site.subdomain), data: { no_turbolink: true }
  end

end