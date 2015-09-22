class DefaultPage < Page
  SLUGS = %w(shows music photos videos)

  belongs_to :feature

  validates_inclusion_of :slug, in: SLUGS
end