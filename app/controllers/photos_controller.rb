class PhotosController < ApplicationController

  def index
    @photos = Photo.published.display_order.page(params[:page]).per(15)
  end

end