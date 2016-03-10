class Admin::DesignsController < Admin::AdminController
  before_action :find_design
  before_action :find_style_snippets, only: :edit

  def edit
  end

  def update
    if @design.update_attributes(design_params)
      redirect_to admin_root_path, notice: "Design successfully updated."
    else
      find_style_snippets
      render :edit
    end
  end

  private

  def find_design
    @design = Design.first
  end

  def find_style_snippets
    @style_snippets = Snippet.grouped_by_extension(:css, :scss)
  end

  def design_params
    params.require(:design).permit(
      :theme, :display_font, :body_font, :scss,
      { color_scheme_attributes: [*ColorScheme::COLOR_ATTRIBUTES, :id] },
      :background_image, :background_image_cache, :remove_background_image,
      :banner_image, :banner_image_cache, :remove_banner_image,
      :logo, :logo_cache, :remove_logo,
      :favicon, :favicon_cache, :remove_favicon
    )
  end

end