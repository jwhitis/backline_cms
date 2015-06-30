class AlbumsController < ApplicationController
  respond_to :html, :js

  def index
    @albums = Album.published.display_order.includes(:tracks)
  end

end