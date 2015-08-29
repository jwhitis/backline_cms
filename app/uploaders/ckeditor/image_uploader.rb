class Ckeditor::ImageUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir
    "uploads/ckeditor/images"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    original_filename.gsub(",", "_")
  end

end