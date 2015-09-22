class Admin::AdminController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"

  def index
  end

  private

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to admin_sign_in_path, alert: "Please sign in to continue."
    end
  end

  def reorder_nav_links!
    ids = NavLink.with_accessible_url.display_order.pluck(:id)
    NavLink.reorder!(ids)
  end

end