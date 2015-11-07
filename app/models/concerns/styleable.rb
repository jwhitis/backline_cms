module Styleable
  extend ActiveSupport::Concern

  included do
    validate :scss_compiles_to_css

    def scss_compiles_to_css
      self.css = Sass.compile(scoped_scss) if self.scss_changed?
    rescue Sass::SyntaxError => exception
      self.errors[:base] << exception.message
    end

    def scoped_scss
      self.scss
    end
  end

end