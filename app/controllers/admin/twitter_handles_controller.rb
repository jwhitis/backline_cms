class Admin::TwitterHandlesController < Admin::AdminController
  before_action :verify_feature_activated!
  feature_name :twitter_feed

  def index
    @twitter_handles = TwitterHandle.display_order
    @twitter_handle = TwitterHandle.new
  end

  def create
    @twitter_handle = TwitterHandle.new(twitter_handle_params)

    if @twitter_handle.save
      TwitterHandle.reload
      @twitter_handle = TwitterHandle.new
      flash.now[:notice] = "Username successfully added."
    end

    @twitter_handles = TwitterHandle.display_order
    render :index
  end

  def destroy
    @twitter_handle = TwitterHandle.find(params[:id])
    @twitter_handle.destroy
    TwitterHandle.reload
    @twitter_handle = TwitterHandle.new
    @twitter_handles = TwitterHandle.display_order
    flash.now[:notice] = "Username successfully removed."
    render :index
  end

  private

  def twitter_handle_params
    params.require(:twitter_handle).permit(:handle)
  end

end