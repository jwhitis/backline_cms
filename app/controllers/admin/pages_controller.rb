class Admin::PagesController < Admin::AdminController

  def index
    @pages = Page.display_order.page(params[:page_number])
  end

end