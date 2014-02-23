class PagesController < ApplicationController
  include ApplicationHelper
  respond_to :js, :html

  def index
    redirect_to admin_signed_in? ? admin_path : releases_path
  end

  def shows
    @shows = Show.order(:date)
  end

  def releases
  end

  def media
    @videos = Video.order(:created_at).reverse_order
  end

  def bio
  end

end