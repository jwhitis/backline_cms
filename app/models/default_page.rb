class DefaultPage < Page
  SLUGS = %w(shows music photos videos)

  belongs_to :feature

  validates_inclusion_of :slug, in: SLUGS

  def self.feature_activated
    joins(feature: :feature_activations).where(
      feature_activations: { site_id: Backline.site.id }
    )
  end

end