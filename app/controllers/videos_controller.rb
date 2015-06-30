class VideosController < ApplicationController
  respond_to :html, :js

  def index
    @videos = Video.published.display_order
  end

end