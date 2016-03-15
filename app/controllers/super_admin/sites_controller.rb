class SuperAdmin::SitesController < SuperAdmin::SuperAdminController
  before_action :find_editable_site, only: [:edit, :update, :destroy]

  def index
    @sites = Site.editable.display_order.page(params[:page])
  end

  def new
    @editable_site = Site.new
  end

  def create
    @editable_site = SiteCreator.new(site_params).create

    if @editable_site.persisted?
      @sites = Site.editable.display_order.page(params[:page])
      flash.now[:notice] = "Site successfully created."
      render :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @editable_site.update_attributes(site_params)
      @sites = Site.editable.display_order.page(params[:page])
      flash.now[:notice] = "Site successfully updated."
      render :index
    else
      render :edit
    end
  end

  def destroy
    @editable_site.destroy
    @sites = Site.editable.display_order.page(params[:page])
    flash.now[:notice] = "Site successfully deleted."
    render :index
  end

  private

  def find_editable_site
    @editable_site = Site.find(params[:id])
  end

  def site_params
    params.require(:site).permit(:title, :subdomain)
  end

end