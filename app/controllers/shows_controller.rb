class ShowsController < ApplicationController
  before_action :verify_feature_activated!
  before_action :find_page

  def index
    @shows = Show.published.display_order.page(params[:page]).per(8)
  end

end