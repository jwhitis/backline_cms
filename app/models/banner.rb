class Banner < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :design
  has_one :link, class_name: "BannerLink", inverse_of: :banner, dependent: :destroy

  accepts_nested_attributes_for :link, reject_if: :reject_link, allow_destroy: true

  validates_presence_of :image, :design_id

  def reject_link attributes
    persisted = attributes[:id].present?
    blank = attributes.except(:id).values.all?(&:blank?)
    attributes.merge!(_destroy: true) if persisted && blank
    !persisted && blank
  end

end
