class Admin::SessionsController < Admin::AdminController
  skip_before_action :require_sign_in, only: [:new, :create]

  def new
    redirect_to admin_path if session[:admin]
  end

  def create
    if params[:password] == ENV['ADMIN_PASSWORD']
      session[:admin] = "D.B. Admin"
      redirect_to admin_path, notice: "Welcome, Dirty Bird."
    else
      flash.now[:alert] = "Nice try, bro."
      render :new
    end
  end

  def destroy
    session.delete(:admin)
    redirect_to admin_sign_in_path, notice: "Adi&oacute;s, Dirty Bird.".html_safe
  end

end