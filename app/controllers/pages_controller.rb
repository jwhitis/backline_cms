class PagesController < ApplicationController

  def index
    redirect_to admin_signed_in? ? admin_path : shows_path
  end

end