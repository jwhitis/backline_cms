class Admin::PagesController < Admin::AdminController

  def index
    @pages = Page.accessible.display_order.page(params[:page_number])
  end

end