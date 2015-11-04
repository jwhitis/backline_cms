class PagesController < ApplicationController

  def index
    @page = @site.splash_page || @site.home_page

    if @page.is_a?(DefaultPage)
      redirect_to home_page_path
    else
      render_page
    end
  end

  def show
    @page = Page.published.find_by_slug!(params[:slug])
    render_page
  end

  private

  def render_page
    options = @page.blank_layout? ? { layout: "blank" } : {}
    render :show, options
  end

end