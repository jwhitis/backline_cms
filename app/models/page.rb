class Page < ActiveRecord::Base
  has_one :nav_link, dependent: :destroy

  validates_presence_of :title
  validates :slug, presence: true, slug: true, uniqueness: { case_sensitive: false }

  def has_styles_or_scripts?
    self.css.present? || self.javascript.present?
  end

  def self.display_order
    order(created_at: :desc)
  end

  def self.published
    where(published: true)
  end

  def self.accessible
    where(id: accessible_ids)
  end

  def self.accessible_ids
    page_ids = CustomPage.published.pluck(:id)
    page_ids + DefaultPage.published.feature_activated.pluck(:id)
  end

end
