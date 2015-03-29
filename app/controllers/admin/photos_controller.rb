class Admin::PhotosController < Admin::AdminController
  respond_to :js

  def index
    @photos = Photo.display_order.page(params[:page])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      @photos = Photo.display_order.page(params[:page])
      flash.now[:notice] = "Photo successfully created."
      render :index
    else
      render :new
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])

    if @photo.update_attributes(photo_params)
      @photos = Photo.display_order.page(params[:page])
      flash.now[:notice] = "Photo successfully updated."
      render :index
    else
      render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    @photos = Photo.display_order.page(params[:page])
    flash.now[:notice] = "Photo successfully deleted."
    render :index
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image, :published)
  end

end