class Admin::DefaultPagesController < Admin::AdminController
  before_action :find_page

  def edit
  end

  def update
    if @page.update_attributes(page_params)
      reorder_nav_links! if @page.nav_link && page_status_changed?
      @pages = Page.with_activated_feature.display_order.page(params[:page_number])
      flash.now[:notice] = "Page successfully updated."
      render "admin/pages/index"
    else
      render :edit
    end
  end

  private

  def find_page
    @page = DefaultPage.with_activated_feature.find(params[:id])
  end

  def page_status_changed?
    @page.previous_changes.include?(:published)
  end

  def page_params
    params.require(:page).permit(:title, :published)
  end

end