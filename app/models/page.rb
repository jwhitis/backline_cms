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

  def self.with_activated_feature
    # Pages that are not linked to a feature or are linked to an activated feature
    joins("LEFT OUTER JOIN features ON features.id = pages.feature_id").
      joins("LEFT OUTER JOIN feature_activations ON feature_activations.feature_id = features.id").
      where("pages.feature_id IS NULL OR feature_activations.site_id = ?", Backline.site.id)
  end

  def self.accessible
    published.with_activated_feature
  end

end
