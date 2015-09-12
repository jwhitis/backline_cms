class Admin::DefaultPagesController < Admin::AdminController
  before_action :find_default_page

  def edit
  end

  def update
    if @default_page.update_attributes(default_page_params)
      @pages = Page.display_order.page(params[:page_number])
      flash.now[:notice] = "Page successfully updated."
      render "admin/pages/index"
    else
      render :edit
    end
  end

  private

  def find_default_page
    @default_page = DefaultPage.find(params[:id])
  end

  def default_page_params
    params.require(:default_page).permit(:title, :published)
  end

end