class PagesController < ApplicationController
  respond_to :js, :html

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