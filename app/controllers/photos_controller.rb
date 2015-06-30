class PhotosController < ApplicationController
  respond_to :html, :js

  def index
    @photos = Photo.published.display_order.page(params[:page]).per(15)
  end

end