class ColorScheme < ActiveRecord::Base
  belongs_to :design

  validates_presence_of :design_id
  validates :background, presence: true, hex_code: true
  validates :foreground, presence: true, hex_code: true
  validates :accent, presence: true, hex_code: true
  validates :text, presence: true, hex_code: true

  after_initialize :set_defaults

  def set_defaults
    self.background ||= Theme.defaults[:background_color]
    self.foreground ||= Theme.defaults[:foreground_color]
    self.accent     ||= Theme.defaults[:accent_color]
    self.text       ||= Theme.defaults[:text_color]
  end

end
