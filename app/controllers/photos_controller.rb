class PhotosController < ApplicationController
  before_action :verify_feature_activated!
  before_action :find_page

  def index
    @photos = Photo.published.display_order.page(params[:page]).per(15)
  end

end