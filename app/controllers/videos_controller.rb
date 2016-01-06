class VideosController < ApplicationController
  before_action :verify_feature_active!
  before_action :find_page

  def index
    @videos = Video.published.display_order
  end

end