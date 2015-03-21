class PagesController < ApplicationController
  include ApplicationHelper
  respond_to :html, :js

  def index
    redirect_to admin_signed_in? ? admin_path : releases_path
  end

  def shows
    @shows = Show.published.recent.page(params[:page]).per(8)
  end

  def releases
  end

  def videos
    @videos = Video.published.order("created_at DESC")
  end

  def bio
  end

end