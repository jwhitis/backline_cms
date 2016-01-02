class SessionsController < ApplicationController

  def new
    if user_signed_in?
      redirect_to after_sign_in_path and return
    end

    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.save
      redirect_to after_sign_in_path
    else
      flash.now[:alert] = "The email or password you entered is incorrect."
      render :new
    end
  end

  def destroy
    current_session.destroy
    redirect_to home_page_path
  end

  private

  def after_sign_in_path
    admin_signed_in? ? admin_root_path : home_page_path
  end

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end

end