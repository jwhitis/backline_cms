class Admin::SessionsController < Admin::AdminController
  skip_before_action :authenticate_admin!, only: [:new, :create]

  def new
    redirect_to admin_root_path if admin_signed_in?
  end

  def create
    if password_is_correct?
      sign_in_admin!
      redirect_to admin_root_path, notice: "You are now signed in."
    else
      flash.now[:alert] = "The password you entered is incorrect."
      render :new
    end
  end

  def destroy
    sign_out_admin!
    redirect_to admin_sign_in_path, notice: "You are now signed out."
  end

  private

  def password_is_correct?
    params[:password] == ENV['ADMIN_PASSWORD']
  end

  def sign_in_admin!
    session[:admin_id] = 1
  end

  def sign_out_admin!
    session.delete(:admin_id)
  end

end