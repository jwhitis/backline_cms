class PagesController < ApplicationController

  def index
    redirect_to homepage_path
  end

  def show
    @page = Page.published.find_by_slug!(params[:slug])
    render layout: "blank" if @page.blank_layout?
  end

  private

  def homepage_path
    homepage = @site.homepage
    "/#{homepage.slug}"
  end

end