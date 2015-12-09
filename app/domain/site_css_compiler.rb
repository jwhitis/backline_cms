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
      background_color_css,
      text_color_css,
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

  def background_color_css
    ".background-color, div#wrapper { background-color: #{@site.background_color}; }"
  end

  def text_color_css
    ".text-color, body, a, a:hover { color: #{@site.text_color}; }"
  end

end