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
      *nav_text_color_css,
      main_background_color_css,
      main_text_color_css,
      footer_background_color_css,
      footer_text_color_css,
      *button_background_color_css,
      button_text_color_css,
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
    ".display-font, .page-title, .btn-main { font-family: #{@site.display_font}; }"
  end

  def body_font_css
    "body, h1, h2, h3, h4, h5, h6 { font-family: #{@site.body_font}; }"
  end

  def nav_background_color_css
    [
      "nav.navbar { background-color: #{@site.nav_background_color}; transition: all .5s ease; }",
      "@media (max-width: 767px) { nav.navbar, div.navbar-collapse { background-color: #{@site.solid_nav_background_color}; box-shadow: 0 3px 8px rgba(0, 0, 0, .1); } }"
    ]
  end

  def nav_text_color_css
    [
      "nav.navbar, nav.navbar a { color: #{@site.nav_text_color}; }",
      ".tcon-menu__lines, .tcon-menu__lines::before, .tcon-menu__lines::after { background: #{@site.nav_text_color}; }"
    ]
  end

  def main_background_color_css
    "div#wrapper { background-color: #{@site.main_background_color}; }"
  end

  def main_text_color_css
    "div#wrapper, a, a:hover, a:focus { color: #{@site.main_text_color}; }"
  end

  def footer_background_color_css
    "footer { background-color: #{@site.footer_background_color}; }"
  end

  def footer_text_color_css
    "footer, footer a, footer a:hover, footer a:focus { color: #{@site.footer_text_color}; }"
  end

  def button_background_color_css
    [
      ".btn-main { background-color: #{@site.button_background_color}; }",
      ".btn-main:hover { opacity: .8; }"
    ]
  end

  def button_text_color_css
    ".btn-main, .btn-main:hover, .btn-main:focus { color: #{@site.button_text_color}; }"
  end

end