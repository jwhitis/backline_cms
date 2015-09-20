class FeatureActivation < ActiveRecord::Base
  belongs_to :site
  belongs_to :feature

  validates_presence_of :site_id, :feature_id
  validates_uniqueness_of :feature_id, scope: :site_id
end
