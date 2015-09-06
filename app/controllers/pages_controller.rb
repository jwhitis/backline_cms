class PagesController < ApplicationController

  def index
    redirect_to homepage_path
  end

  def show
    @page = Page.published.find_by_slug!(params[:slug])
  end

  private

  def homepage_path
    homepage = Backline.configuration.homepage
    "/#{homepage.slug}"
  end

end