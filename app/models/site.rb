class Site < ActiveRecord::Base
  has_many :feature_activations, dependent: :destroy
  has_many :features, through: :feature_activations
  has_one :design

  validates_presence_of :title, :homepage_id
  validate :homepage_must_be_published

  def homepage_must_be_published
    unless Page.published.find_by(id: self.homepage_id)
      self.errors.add(:homepage_id, "must be a published page")
    end
  end

  def reload options = nil
    @homepage = nil
    @feature_names = nil
    super
  end

  def homepage
    @homepage ||= Page.find(self.homepage_id)
  end

  def feature_names
    @feature_names ||= self.features.pluck(:name)
  end

end
