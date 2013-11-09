class PagesController < ApplicationController
  respond_to :js, :html

  def shows
    @shows = Show.order(:date)
  end

  def releases
  end

  def media
  end

  def bio
  end
end