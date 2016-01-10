class PasswordResetsController < ApplicationController
  before_action :verify_user_signed_out!, only: [:new, :edit]
  before_action :find_user, only: [:edit, :update]

  def new
  end

  def create
    if @user = User.find_by_email(params[:email])
      @user.deliver_password_reset_email!
      flash[:notice] = "You have been emailed instructions for resetting your password."
      redirect_to home_page_path
    else
      flash.now[:alert] = "We could not find a user with that email address."
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(password_reset_params)
      redirect_to after_sign_in_path, notice: "Your password has been reset."
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find_by_perishable_token!(params[:id])
  end

  def password_reset_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end