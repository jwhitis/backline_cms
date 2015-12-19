class SiteCSSCompiler

  def initialize site
    @site = site
  end

  def css
    [
      background_image_css,
      banner_image_css,
      display_font_css,
      body_font_css,
      nav_background_color_css,
      nav_text_color_css,
      main_background_color_css,
      main_text_color_css,
      @site.css
    ].reject(&:blank?).join("\n")
  end

  private

  def background_image_css
    return "" if @site.background_image_url.nil?

    "div#main { background-image: url(#{@site.background_image_url}); }"
  end

  def banner_image_css
    return "" if @site.banner_image_url.nil?

    "div#banner { background-image: url(#{@site.banner_image_url}); }"
  end

  def display_font_css
    ".display-font, .page-title, .btn-main, .flash-main { font-family: #{@site.display_font}; }"
  end

  def body_font_css
    "body, h1, h2, h3, h4, h5, h6 { font-family: #{@site.body_font}; }"
  end

  def nav_background_color_css
    ".nav-background-color, nav.navbar, div.navbar-collapse { background-color: #{@site.nav_background_color}; }"
  end

  def nav_text_color_css
    ".nav-text-color, nav.navbar, nav.navbar a { color: #{@site.nav_text_color}; }"
  end

  def main_background_color_css
    "div#wrapper { background-color: #{@site.main_background_color}; }"
  end

  def main_text_color_css
    "div#wrapper, a, a:hover, a:focus { color: #{@site.main_text_color}; }"
  end

end