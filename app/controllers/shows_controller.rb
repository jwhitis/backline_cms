class ShowsController < ApplicationController
  respond_to :html, :js

  def index
    @shows = Show.published.display_order.page(params[:page]).per(8)
  end

end