class Design < ActiveRecord::Base
  include Styleable

  mount_uploader :background_image, ImageUploader
  mount_uploader :banner_image, ImageUploader
  mount_uploader :logo, ImageUploader
  mount_uploader :favicon, FaviconUploader

  belongs_to :site
  has_one :color_scheme, dependent: :destroy

  accepts_nested_attributes_for :color_scheme

  validates_presence_of :theme, :site_id
  validates :display_font, presence: true, inclusion: { in: GoogleFonts::DISPLAY_FONTS }
  validates :body_font, presence: true, inclusion: { in: GoogleFonts::BODY_FONTS }

  after_initialize :set_defaults

  def set_defaults
    self.theme        ||= Theme.defaults[:title]
    self.display_font ||= Theme.defaults[:display_font]
    self.body_font    ||= Theme.defaults[:body_font]
  end

  def background_image_url
    self.background_image.background.url
  end

  def banner_image_url
    self.banner_image.banner.url
  end

  def logo_url
    self.logo.logo.url
  end

  def favicon_url
    self.favicon.display.url
  end

end
