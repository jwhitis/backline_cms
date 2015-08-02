class VideosController < ApplicationController

  def index
    @videos = Video.published.display_order
  end

end