class Admin::CustomPagesController < Admin::AdminController
  before_action :find_custom_page, only: [:edit, :update, :destroy]
  after_action :delete_unused_images!, only: [:create, :update]

  def new
    @custom_page = CustomPage.new
  end

  def create
    @custom_page = CustomPage.new(custom_page_params)

    if @custom_page.valid? && params[:preview]
      render :preview and return
    elsif params[:edit]
      render :new and return
    end

    if @custom_page.save
      @pages = Page.display_order.page(params[:page_number])
      flash.now[:notice] = "Page successfully created."
      render "admin/pages/index"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @custom_page.assign_attributes(custom_page_params)

    if @custom_page.valid? && params[:preview]
      render :preview and return
    elsif params[:edit]
      render :edit and return
    end

    if @custom_page.save
      @pages = Page.display_order.page(params[:page_number])
      flash.now[:notice] = "Page successfully updated."
      render "admin/pages/index"
    else
      render :edit
    end
  end

  def destroy
    @custom_page.destroy
    @pages = Page.display_order.page(params[:page_number])
    flash.now[:notice] = "Page successfully deleted."
    render "admin/pages/index"
  end

  private

  def find_custom_page
    @custom_page = CustomPage.find(params[:id])
  end

  def delete_unused_images!
    image_filenames.each do |filename|
      unless @custom_page.body.include?(filename)
        uploader = Ckeditor::ImageUploader.new
        uploader.retrieve_from_store!(filename)
        uploader.remove!
      end
    end

    cookies.delete(:ckeditor_images)
  end

  def image_filenames
    cookies.signed[:ckeditor_images].try(:split, ",") || []
  end

  def custom_page_params
    params.require(:custom_page).permit(:title, :slug, :body, :published, :scss, :javascript)
  end

end