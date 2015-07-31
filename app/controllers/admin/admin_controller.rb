class Admin::AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @pages = Page.editable.display_order.page(params[:page_number])
  end

  def refresh_nav_links
    flash.now[:notice] = "Nav successfully refreshed."

    respond_to do |format|
      format.js { render :refresh_nav }
    end
  end

  def refresh_player_tracks
    flash.now[:notice] = "Audio successfully refreshed."

    respond_to do |format|
      format.js { render :refresh_nav }
    end
  end

  private

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to admin_sign_in_path, alert: "Please sign in to continue."
    end
  end

end