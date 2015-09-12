class ShowsController < ApplicationController
  before_action :find_default_page

  def index
    @shows = Show.published.display_order.page(params[:page]).per(8)
  end

end