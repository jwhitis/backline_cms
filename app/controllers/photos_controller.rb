class PhotosController < ApplicationController
  before_action :find_default_page

  def index
    @photos = Photo.published.display_order.page(params[:page]).per(15)
  end

end