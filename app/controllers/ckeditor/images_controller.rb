class Ckeditor::ImagesController < ApplicationController

  def create
    @uploader = Ckeditor::ImageUploader.new

    @uploader.store!(params[:upload])
    store_image_filename!
    render text: success_script
  rescue CarrierWave::IntegrityError
    render text: failure_script
  end

  private

  def store_image_filename!
    existing_filenames = cookies.signed[:ckeditor_images]
    cookies.signed[:ckeditor_images] = [existing_filenames, @uploader.filename].compact.join(",")
  end

  def success_script
    "<script type='text/javascript'>
      window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, '#{@uploader.url}');
    </script>"
  end

  def failure_script
    "<script type='text/javascript'>
      alert('You must choose an image in one of these formats: JPG, JPEG, GIF, PNG. Please close the image dialog and try again.');
    </script>"
  end

end