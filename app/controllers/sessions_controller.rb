class SessionsController < ApplicationController
  before_action :verify_user_signed_out!, except: :destroy

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)

    if @session.save
      # The current session needs to be reloaded after the user signs in
      # so that #after_sign_in_path will return the correct value.
      remove_instance_variable(:@current_session)
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

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end

end