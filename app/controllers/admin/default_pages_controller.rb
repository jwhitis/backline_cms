class Admin::DefaultPagesController < Admin::AdminController
  before_action :find_page

  def edit
  end

  def update
    if @page.update_attributes(page_params)
      @pages = Page.display_order.page(params[:page_number])
      flash.now[:notice] = "Page successfully updated."
      render "admin/pages/index"
    else
      render :edit
    end
  end

  private

  def find_page
    @page = DefaultPage.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :published)
  end

end