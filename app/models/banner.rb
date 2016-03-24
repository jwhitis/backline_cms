class Banner < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :design
  has_one :link, class_name: "BannerLink", inverse_of: :banner, dependent: :destroy

  validates_presence_of :image, :design_id

  accepts_nested_attributes_for :link, reject_if: :all_blank
end
