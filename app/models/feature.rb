class Feature < ActiveRecord::Base
  NAMES = %w(Shows Music Photos Videos Audio Twitter Users)

  has_many :feature_activations, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
