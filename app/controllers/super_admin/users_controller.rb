class SuperAdmin::UsersController < SuperAdmin::SuperAdminController
  before_action :find_user, only: [:edit, :update, :destroy]

  def index
    @users = User.display_order.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    password = SecureRandom.hex
    @user.assign_attributes(password: password, password_confirmation: password)

    if @user.save
      @user.deliver_new_account_email!
      @users = User.display_order.page(params[:page])
      flash.now[:notice] = "An email has been sent to notify this user that an account has been created for them."
      render :index
    else
      render :new
    end
  end

  def edit
    @roles = @user.roles.includes(:site)
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
    flash.now[:notice] = "User successfully deleted."
    render :index
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :super_admin)
  end

end