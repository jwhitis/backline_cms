class Admin::AdminController < ApplicationController
  before_action :require_sign_in

  def index
    @shows = Show.order(:date)
  end

  private

  def require_sign_in
    unless session[:admin]
      redirect_to admin_sign_in_path, alert: "Please, sign in first."
    end
  end

end