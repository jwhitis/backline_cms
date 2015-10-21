class FaviconUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore.pluralize}/#{model.id}/#{mounted_as}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("default_image.png")
  end

  version :display do
    process resize_to_fill: [16, 16]
  end

  def extension_white_list
    %w(ico gif png)
  end

end
