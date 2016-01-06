class NavLink < ActiveRecord::Base
  include Orderable

  belongs_to :page

  validates :text, presence: true, length: { maximum: 15 }, uniqueness: { case_sensitive: false }
  validates :external_url, url: true, allow_blank: true
  validate :page_or_external_url_must_be_present

  def page_or_external_url_must_be_present
    unless page_or_external_url_present? && page_or_external_url_blank?
      self.errors[:base] << "You must either choose a page or enter a URL"
    end
  end

  def page_or_external_url_present?
    self.page || self.external_url.present?
  end

  def page_or_external_url_blank?
    self.page.nil? || self.external_url.blank?
  end

  def url
    if self.page
      self.page.path
    elsif self.external_url.present?
      self.external_url
    end
  end

  def self.with_accessible_url
    # Nav links that either have an external URL or belong to a page that is published
    # and either does not belong to a feature or belongs to an active feature
    joins("LEFT OUTER JOIN pages ON pages.id = nav_links.page_id").
      joins("LEFT OUTER JOIN features ON features.id = pages.feature_id").
      joins("LEFT OUTER JOIN feature_activations ON feature_activations.feature_id = features.id").
      where("nav_links.page_id IS NULL OR (pages.published = true AND (pages.feature_id IS NULL OR feature_activations.site_id = ?))", Backline.site.id)
  end

end
