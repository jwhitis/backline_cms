class Admin::SitesController < Admin::AdminController
  before_action :find_site

  def edit
  end

  def update
    if @site.update_attributes(site_params)
      Backline.reload
      redirect_to admin_root_path, notice: "Settings successfully updated."
    else
      render :edit
    end
  end

  private

  def find_site
    @site = Backline.site
  end

  def site_params
    params.require(:site).permit(:homepage_id)
  end

end