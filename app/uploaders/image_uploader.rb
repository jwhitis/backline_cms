# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore.pluralize}/#{model.id}/#{mounted_as}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb, if: :thumb? do
    # The height is arbitrarily large so that the width always constrains the image.
    process resize_to_fit: [345, 9999]
  end

  version :display, if: :display? do
    process resize_to_fit: [720, 560]
  end

  version :square, if: :square? do
    process resize_to_fill: [500, 500]
  end

  version :background, if: :background? do
    process resize_to_fill: [1280, 800]
  end

  version :banner, if: :banner? do
    process resize_to_fill: [1280, 300]
  end

  version :logo, if: :logo? do
    # The width is arbitrarily large so that the height always constrains the image.
    process resize_to_fit: [9999, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  private

  def thumb? image
    model.is_a?(Photo)
  end

  def display? image
    model.is_a?(Photo)
  end

  def square? image
    model.is_a?(Album)
  end

  def background? image
    model.is_a?(Design) && mounted_as == :background_image
  end

  def banner? image
    model.is_a?(Design) && mounted_as == :banner_image
  end

  def logo? image
    model.is_a?(Design) && mounted_as == :logo
  end

end
