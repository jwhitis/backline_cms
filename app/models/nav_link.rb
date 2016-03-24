class NavLink < Link
  include SiteScope
  include Orderable

  validates_presence_of :position, :site_id
  validates :text, presence: true, length: { maximum: 15 },
    uniqueness: { scope: :site_id, case_sensitive: false }

  def self.with_accessible_url
    # Nav links that either have an external URL or belong to a page that is published
    # and either does not belong to a feature or belongs to an active feature
    joins("LEFT OUTER JOIN pages ON pages.id = links.page_id").
      joins("LEFT OUTER JOIN features ON features.id = pages.feature_id").
      joins("LEFT OUTER JOIN feature_activations ON feature_activations.feature_id = features.id").
      where("links.page_id IS NULL OR (pages.published = true AND (pages.feature_id IS NULL OR feature_activations.site_id = ?))", Site.current_id)
  end

end
