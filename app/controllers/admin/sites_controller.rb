class Admin::SitesController < Admin::AdminController
  before_action :store_feature_ids, only: :update

  def edit
  end

  def update
    if @site.update_attributes(site_params)
      reorder_nav_links! if site_features_changed?
      Backline.reload
      redirect_to admin_root_path, notice: "Settings successfully updated."
    else
      render :edit
    end
  end

  private

  def store_feature_ids
    @feature_ids = @site.feature_ids
  end

  def site_features_changed?
    @feature_ids != @site.feature_ids
  end

  def site_params
    params.require(:site).permit(:homepage_id, :title, :description, feature_ids: [])
  end

end