class PagesController < ApplicationController
  include ApplicationHelper
  respond_to :html, :js

  def index
    redirect_to admin_signed_in? ? admin_path : releases_path
  end

  def shows
    @upcoming_shows = Show.upcoming.limit(2)
    @more_upcoming_shows = Show.upcoming.offset(2)
    @past_shows = Show.past.limit(2)
    @more_past_shows = Show.past.offset(2)
  end

  def releases
  end

  def media
    @videos = Video.published.order("created_at DESC")
  end

  def bio
  end

end