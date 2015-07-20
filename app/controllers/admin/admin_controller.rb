class Admin::AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @pages = Page.display_order.page(params[:page_number])
  end

  def refresh_player
    flash.now[:notice] = "Audio player successfully refreshed."
    respond_to :js
  end

  private

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to admin_sign_in_path, alert: "Please sign in to continue."
    end
  end

end