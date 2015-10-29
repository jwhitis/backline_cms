class Admin::DesignsController < Admin::AdminController
  before_action :find_design

  def edit
  end

  def update
    if @design.update_attributes(design_params)
      Backline.reload
      redirect_to admin_root_path, notice: "Design successfully updated."
    else
      render :edit
    end
  end

  private

  def find_design
    design_id = @site.design.id
    @design = Design.find(design_id)
  end

  def design_params
    params.require(:design).permit(
      :theme, :display_font, :body_font,
      { color_scheme_attributes: [:background, :foreground, :accent, :text] },
      :background_image, :background_image_cache, :remove_background_image,
      :banner_image, :banner_image_cache, :remove_banner_image,
      :logo, :logo_cache, :remove_logo,
      :favicon, :favicon_cache, :remove_favicon
    )
  end

end