class ShowsController < ApplicationController

  def index
    @shows = Show.published.display_order.page(params[:page]).per(8)
  end

end