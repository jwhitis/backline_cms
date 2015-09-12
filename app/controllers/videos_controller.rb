class VideosController < ApplicationController
  before_action :find_default_page

  def index
    @videos = Video.published.display_order
  end

end