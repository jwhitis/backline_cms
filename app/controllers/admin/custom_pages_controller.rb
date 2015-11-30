class Admin::CustomPagesController < Admin::AdminController
  before_action :find_grouped_snippets, only: [:new, :edit]
  before_action :find_page, only: [:edit, :update, :destroy]
  after_action :delete_unused_images!, only: [:create, :update]

  def new
    @page = CustomPage.new
  end

  def create
    @page = CustomPage.new(page_params)

    if @page.valid? && params[:preview]
      render :preview and return
    elsif params[:edit]
      find_grouped_snippets
      render :new and return
    end

    if @page.save
      @pages = Page.with_activated_feature.display_order.page(params[:page_number])
      flash.now[:notice] = "Page successfully created."
      render "admin/pages/index"
    else
      find_grouped_snippets
      render :new
    end
  end

  def edit
  end

  def update
    @page.assign_attributes(page_params)

    if @page.valid? && params[:preview]
      render :preview and return
    elsif params[:edit]
      find_grouped_snippets
      render :edit and return
    end

    if @page.save
      reorder_nav_links! if @page.nav_link && page_status_changed?
      @pages = Page.with_activated_feature.display_order.page(params[:page_number])
      flash.now[:notice] = "Page successfully updated."
      render "admin/pages/index"
    else
      find_grouped_snippets
      render :edit
    end
  end

  def destroy
    @page.destroy
    reorder_nav_links! if @page.nav_link
    @pages = Page.with_activated_feature.display_order.page(params[:page_number])
    flash.now[:notice] = "Page successfully deleted."
    render "admin/pages/index"
  end

  private

  def find_grouped_snippets
    @content_snippets = Snippet.grouped_by_extension(:txt, :html)
    @style_snippets   = Snippet.grouped_by_extension(:css, :scss)
    @script_snippets  = Snippet.grouped_by_extension(:js)
  end

  def find_page
    @page = CustomPage.find(params[:id])
  end

  def page_status_changed?
    @page.previous_changes.include?(:published)
  end

  def delete_unused_images!
    image_filenames.each do |filename|
      unless @page.html.include?(filename)
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

  def page_params
    params.require(:page).permit(:title, :slug, :html, :published, :scss, :javascript,
      :blank_layout, :exclusive_content)
  end

end