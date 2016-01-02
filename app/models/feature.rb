class Feature < ActiveRecord::Base
  NAMES = %w(shows albums photos videos audio_player twitter_feed mailing_list)

  has_many :feature_activations, dependent: :destroy

  validates :name, presence: true, inclusion: { in: NAMES }, uniqueness: { case_sensitive: false }

  def self.unactivated
    joins("LEFT OUTER JOIN feature_activations ON feature_activations.feature_id = features.id").
      where(feature_activations: { feature_id: nil })
  end

end
