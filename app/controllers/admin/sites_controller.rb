class Admin::SitesController < Admin::AdminController
  before_action :find_editable_site
  before_action :store_feature_ids, only: :update
  authorized_roles :super_admin, :site_admin

  def edit
  end

  def update
    if @editable_site.update_attributes(site_params)
      reorder_nav_links! if site_features_changed?
      flash[:notice] = "Settings successfully updated."
      # Form the entire URL in case the subdomain has changed.
      redirect_to admin_root_url(subdomain: @editable_site.subdomain)
    else
      render :edit
    end
  end

  private

  def find_editable_site
    @editable_site = Site.find(@site.id)
  end

  def store_feature_ids
    @feature_ids = @editable_site.feature_ids
  end

  def site_features_changed?
    @feature_ids != @editable_site.feature_ids
  end

  def site_params
    params.require(:site).permit(:home_page_id, :title, :description, { feature_ids: [] },
      :splash_page_id, :subscriber_message, :subdomain)
  end

end