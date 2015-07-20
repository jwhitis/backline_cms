class Page < ActiveRecord::Base
  VALID_SLUG_REGEX = /\A[a-z0-9\-_]+\z/

  mount_uploader :image, ImageUploader

  has_one :nav_link, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true, format: { with: VALID_SLUG_REGEX }, uniqueness: true

  before_validation :format_slug

  def format_slug
    if self.slug_changed?
      text = [self.slug, self.title].find(&:present?) || ""
      self.slug = text.parameterize
    end
  end

  def self.display_order
    order(created_at: :desc)
  end

end
