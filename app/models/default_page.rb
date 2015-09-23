class DefaultPage < Page
  SLUGS = %w(shows music photos videos)

  belongs_to :feature

  validates_inclusion_of :slug, in: SLUGS

  after_initialize :set_published

  def set_published
    self.published = true if self.published.nil?
    true # Object becomes invalid if a callback returns false
  end

end