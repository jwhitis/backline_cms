class CustomPage < Page
  validate :scss_compiles_to_css

  after_initialize :set_published
  before_validation :format_slug

  def scss_compiles_to_css
    self.css = Sass.compile(scoped_scss) if self.scss_changed?
  rescue Sass::SyntaxError => exception
    self.errors[:base] << exception.message
  end

  def scoped_scss
    "div#page-container { #{self.scss} }"
  end

  def set_published
    self.published = false if self.published.nil?
    true # Object becomes invalid if a callback returns false
  end

  def format_slug
    if self.slug_changed?
      text = [self.slug, self.title].find(&:present?) || ""
      self.slug = text.parameterize
    end
  end

end