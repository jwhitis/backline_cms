class Admin::AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @shows = Show.order(:date)
  end

  private

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to admin_sign_in_path, alert: "Please sign in to continue."
    end
  end

end