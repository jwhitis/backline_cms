class DefaultPage < Page
  SLUGS = %w(shows albums photos videos exclusive-content)

  belongs_to :feature

  after_initialize :set_published

  def set_published
    self.published = true if self.published.nil?
    true # Object becomes invalid if a callback returns false
  end

end