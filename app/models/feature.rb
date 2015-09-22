class Feature < ActiveRecord::Base
  NAMES = %w(Shows Music Photos Videos Audio Twitter Users)

  has_many :feature_activations, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.unactivated
    joins("LEFT OUTER JOIN feature_activations ON feature_activations.feature_id = features.id").
      where(feature_activations: { feature_id: nil })
  end

end
