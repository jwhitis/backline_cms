module PhotosHelper

  def photo_caption photo
    "<div class='photo-caption'>#{photo.caption}</div>"
  end

end