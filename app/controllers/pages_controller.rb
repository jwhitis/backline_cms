class PagesController < ApplicationController

  def index
    redirect_to homepage_path
  end

  def show
    @page = Page.published.find_by_slug!(params[:slug])
    render layout: "standalone" if @page.standalone?
  end

  private

  def homepage_path
    homepage = Backline.site.homepage
    "/#{homepage.slug}"
  end

end