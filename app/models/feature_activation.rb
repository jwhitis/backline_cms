class FeatureActivation < ActiveRecord::Base
  belongs_to :site
  belongs_to :feature

  validates_presence_of :site_id
  validates :feature_id, presence: true, uniqueness: { scope: :site_id }
end
