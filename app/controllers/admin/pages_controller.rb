class Admin::PagesController < Admin::AdminController

  def index
    @pages = Page.with_active_feature.display_order.page(params[:page_number])
  end

end