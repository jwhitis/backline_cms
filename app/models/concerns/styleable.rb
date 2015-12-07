module Styleable
  extend ActiveSupport::Concern

  included do
    validate :scss_compiles_to_css, if: :scss_changed?

    def scss_compiles_to_css
      self.css = Sass.compile(scoped_scss)
    rescue Sass::SyntaxError => exception
      self.errors[:base] << exception.message
    end

    def scoped_scss
      self.scss
    end
  end

end