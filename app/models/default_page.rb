class DefaultPage < Page
  SLUGS = %w(shows music photos videos)

  validates_inclusion_of :slug, in: SLUGS
end