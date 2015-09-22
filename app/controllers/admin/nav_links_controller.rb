class Admin::NavLinksController < Admin::AdminController
  before_action :find_nav_link, only: [:edit, :update, :destroy]

  def index
    @nav_links = NavLink.with_accessible_url.display_order
  end

  def new
    @nav_link = NavLink.new
  end

  def create
    @nav_link = NavLink.new(nav_link_params)

    if @nav_link.save
      reorder_nav_links!
      @nav_links = NavLink.with_accessible_url.display_order
      flash.now[:notice] = "Nav link successfully added."
      render :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @nav_link.update_attributes(nav_link_params)
      @nav_links = NavLink.with_accessible_url.display_order
      flash.now[:notice] = "Nav link successfully updated."
      render :index
    else
      render :edit
    end
  end

  def destroy
    @nav_link.destroy
    reorder_nav_links!
    @nav_links = NavLink.with_accessible_url.display_order
    flash.now[:notice] = "Nav link successfully removed."
    render :index
  end

  def reorder
    NavLink.reorder!(params[:resource_ids])
    @nav_links = NavLink.with_accessible_url.display_order
    render :index
  end

  private

  def find_nav_link
    @nav_link = NavLink.with_accessible_url.find(params[:id])
  end

  def nav_link_params
    params.require(:nav_link).permit(:text, :external_url, :page_id)
  end

end