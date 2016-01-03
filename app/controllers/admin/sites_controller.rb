class Admin::SitesController < Admin::AdminController
  before_action :find_editable_site
  before_action :store_feature_ids, only: :update
  authorized_roles :site_admin

  def edit
  end

  def update
    if @editable_site.update_attributes(site_params)
      reorder_nav_links! if site_features_changed?
      Backline.reload
      redirect_to admin_root_path, notice: "Settings successfully updated."
    else
      render :edit
    end
  end

  private

  # This is necessary because reloading the Site object doesn't clear
  # its validation errors.
  def find_editable_site
    site_id = @site.id
    @editable_site = Site.find(site_id)
  end

  def store_feature_ids
    @feature_ids = @editable_site.feature_ids
  end

  def site_features_changed?
    @feature_ids != @editable_site.feature_ids
  end

  def site_params
    params.require(:site).permit(:home_page_id, :title, :description, { feature_ids: [] },
      :splash_page_id, :subscriber_message)
  end

end