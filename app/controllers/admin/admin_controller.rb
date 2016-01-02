class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!
  authorized_roles *Role::ADMIN_NAMES
  layout "admin"

  def index
  end

  private

  def reorder_nav_links!
    ids = NavLink.with_accessible_url.display_order.pluck(:id)
    NavLink.reorder!(ids)
  end

end