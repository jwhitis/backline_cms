class Admin::UsersController < Admin::AdminController
  before_action :find_user, only: [:edit, :update, :destroy]
  authorized_roles :site_admin

  def index
    @users = User.display_order.page(params[:page])
  end

  def new
    @user = User.new
    @role = @user.roles.build(site: @site)
  end

  def create
    @user = User.find_or_initialize_by(email: user_email)
    @user.assign_attributes(user_params)

    if @user.new_record?
      password = SecureRandom.hex
      @user.assign_attributes(password: password, password_confirmation: password)
    end

    if @user.save
      @users = User.display_order.page(params[:page])
      flash.now[:notice] = "User successfully added."
      render :index
    else
      @role = @user.roles.find(&:new_record?)
      render :new
    end
  end

  def edit
    @role = @user.current_role
  end

  def update
    if @user.update_attributes(user_params)
      @users = User.display_order.page(params[:page])
      flash.now[:notice] = "User successfully updated."
      render :index
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    @users = User.display_order.page(params[:page])
    flash.now[:notice] = "User successfully removed."
    render :index
  end

  private

  def user_email
    params[:user][:email]
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, { roles_attributes: [:name, :site_id, :id] })
  end

end