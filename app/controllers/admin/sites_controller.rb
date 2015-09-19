class Admin::SitesController < Admin::AdminController

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

  def site_params
    params.require(:site).permit(:homepage_id, :title, :description)
  end

end