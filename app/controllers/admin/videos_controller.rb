class Admin::VideosController < ApplicationController

  def index
    @videos = Video.order(:created_at).reverse_order
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to admin_videos_path, notice: "Video successfully created."
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
      redirect_to admin_videos_path, notice: "Video successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to admin_videos_path, notice: "Video successfully deleted."
  end

  private

  def video_params
    params.require(:video).permit(:title, :caption, :embed)
  end

end
