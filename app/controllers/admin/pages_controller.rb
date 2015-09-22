class Admin::PagesController < Admin::AdminController

  def index
    @pages = Page.with_activated_feature.display_order.page(params[:page_number])
  end

end