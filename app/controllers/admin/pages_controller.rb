class Admin::PagesController < Admin::AdminController
  before_action :find_page, only: [:edit, :update, :destroy]
  respond_to :js

  def index
    @pages = Page.editable.display_order.page(params[:page_number])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      @pages = Page.editable.display_order.page(params[:page_number])
      flash.now[:notice] = "Page successfully created."
      render :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @page.update_attributes(page_params)
      @pages = Page.editable.display_order.page(params[:page_number])
      flash.now[:notice] = "Page successfully updated."
      render :index
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
    @pages = Page.editable.display_order.page(params[:page_number])
    flash.now[:notice] = "Page successfully deleted."
    render :index
  end

  private

  def find_page
    @page = Page.editable.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :slug, :body, :image, :image_cache, :remove_image,
      :video_embed, :published)
  end

end