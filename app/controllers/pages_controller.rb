class PagesController < ApplicationController

  def index
    redirect_to admin_signed_in? ? admin_path : shows_path
  end

  def show
    @page = Page.published.find_by_slug(params[:slug])
    respond_to :html, :js
  end

end