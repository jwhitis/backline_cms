module PhotosHelper

  def photo_caption photo
    return "" if photo.caption.blank?

    "<div class='photo-caption'>#{photo.caption}</div>"
  end

end