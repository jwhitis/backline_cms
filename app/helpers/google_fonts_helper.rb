module GoogleFontsHelper

  def google_fonts_link_tag display_font, body_font
    fonts = [display_font, "#{body_font}:300,400,400italic,700"]
    fonts_string = fonts.join("|").gsub(" ", "+")
    stylesheet_url = google_fonts_stylesheet_url(fonts_string)

    stylesheet_link_tag(stylesheet_url, media: "all")
  end

  def google_fonts_admin_link_tags
    tags = []
    tags << google_fonts_admin_link_tag(GoogleFonts::DISPLAY_FONTS, display_font_sample_text)
    tags << google_fonts_admin_link_tag(GoogleFonts::BODY_FONTS, body_font_sample_text)
    tags.join("\n").html_safe
  end

  def google_fonts_admin_link_tag fonts, sample_text
    fonts_string = fonts.join("|").gsub(" ", "+")
    stylesheet_url = google_fonts_stylesheet_url(fonts_string, sample_text)

    stylesheet_link_tag(stylesheet_url, media: "all")
  end

  def display_font_sample_text
    @site.title
  end

  def body_font_sample_text
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed lectus scelerisque, porttitor massa eget, imperdiet nisi. Cras ut purus sit amet dolor tristique luctus sit amet eu arcu. Pellentesque tempus non felis quis suscipit. Vivamus quis posuere arcu. Pellentesque."
  end

  def google_fonts_stylesheet_url fonts_string, sample_text = nil
    query_params = { family: fonts_string }
    query_params[:text] = url_encode(sample_text) if sample_text
    query_string = query_params.map { |key, value| "#{key}=#{value}" }.join("&")

    GoogleFonts.base_url + "?" + query_string
  end

end