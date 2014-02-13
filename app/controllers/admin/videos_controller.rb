class Admin::VideosController < Admin::AdminController
  respond_to :js

  def index
    @videos = Video.order(:created_at)
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      @videos = Video.order(:created_at)
      flash.now[:notice] = "Video successfully created."
      render :index
    else
      render :new
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(video_params)
      @videos = Video.order(:created_at)
      flash.now[:notice] = "Video successfully updated."
      render :index
    else
      render :edit
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    @videos = Video.order(:created_at)
    flash.now[:notice] = "Video successfully deleted."
  end

  private

  def video_params
    params.require(:video).permit(:title, :caption, :embed)
  end

end