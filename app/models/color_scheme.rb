class ColorScheme < ActiveRecord::Base
  COLOR_ATTRIBUTES = [:nav_background, :nav_text, :main_background, :main_text,
    :footer_background, :footer_text, :button_background, :button_text]

  belongs_to :design

  validates_presence_of :design_id

  COLOR_ATTRIBUTES.each do |attribute|
    validates attribute, presence: true, hex_code: true
  end

  after_initialize :set_defaults

  def set_defaults
    COLOR_ATTRIBUTES.each do |attribute|
      if self.send(attribute).nil?
        value = Theme.defaults.fetch(attribute)
        self.send("#{attribute}=", value)
      end
    end
  end

end
