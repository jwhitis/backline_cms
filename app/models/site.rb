class Site < ActiveRecord::Base
  validates_presence_of :title, :homepage_id
  validate :homepage_must_be_published

  def homepage_must_be_published
    unless Page.published.find_by(id: self.homepage_id)
      errors.add(:homepage_id, "must be a published page")
    end
  end

  def reload options = nil
    @homepage = nil
    super
  end

  def homepage
    @homepage ||= Page.find(self.homepage_id)
  end

end
