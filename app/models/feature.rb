class Feature < ActiveRecord::Base
  NAMES = %w(shows albums photos videos audio_player twitter_feed mailing_list)

  has_many :feature_activations, dependent: :destroy

  validates :name, presence: true, inclusion: { in: NAMES }, uniqueness: { case_sensitive: false }

  def self.inactive
    joins("LEFT OUTER JOIN feature_activations ON feature_activations.feature_id = features.id").
      where("feature_activations.site_id IS NULL OR feature_activations.site_id != ?", Backline.site.id).
      group("features.id")
  end

end
