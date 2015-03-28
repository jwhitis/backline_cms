class PagesController < ApplicationController
  include ApplicationHelper
  respond_to :html, :js

  def index
    redirect_to admin_signed_in? ? admin_path : shows_path
  end

  def shows
    @shows = Show.published.display_order.page(params[:page]).per(8)
  end

  def music
  end

  def photos
  end

  def videos
    @videos = Video.published.display_order
  end

end