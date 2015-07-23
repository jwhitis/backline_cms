class Page < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  has_one :nav_link, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true, slug: true, uniqueness: true

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

  def self.published
    where(published: true)
  end

end
