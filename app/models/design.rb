class Design < ActiveRecord::Base
  mount_uploader :background_image, ImageUploader
  mount_uploader :banner_image, ImageUploader
  mount_uploader :logo, ImageUploader
  mount_uploader :favicon, FaviconUploader

  belongs_to :site
end
