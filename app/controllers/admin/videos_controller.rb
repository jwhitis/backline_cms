class Admin::VideosController < Admin::AdminController
  before_action :find_video, only: [:edit, :update, :destroy]
  respond_to :js

  def index
    @videos = Video.display_order.page(params[:page])
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      @videos = Video.display_order.page(params[:page])
      flash.now[:notice] = "Video successfully created."
      render :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @video.update_attributes(video_params)
      @videos = Video.display_order.page(params[:page])
      flash.now[:notice] = "Video successfully updated."
      render :index
    else
      render :edit
    end
  end

  def destroy
    @video.destroy
    @videos = Video.display_order.page(params[:page])
    flash.now[:notice] = "Video successfully deleted."
    render :index
  end

  private

  def find_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :caption, :embed, :published)
  end

end