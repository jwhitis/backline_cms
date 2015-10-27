module GoogleFonts
  DISPLAY_FONTS = ["Oswald", "Montserrat", "Playfair Display", "Vollkorn"]
  BODY_FONTS = ["Open Sans", "Lato", "Merriweather", "Josefin Slab"]

  class << self

    def all_fonts
      DISPLAY_FONTS + BODY_FONTS
    end

    def base_url
      "https://fonts.googleapis.com/css"
    end

  end
end