class PagesController < ApplicationController

  def index
    redirect_to homepage_path
  end

  def show
    @custom_page = CustomPage.published.find_by_slug!(params[:slug])
  end

  private

  def homepage_path
    homepage = Backline.site.homepage
    "/#{homepage.slug}"
  end

end