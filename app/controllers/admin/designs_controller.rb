class Admin::DesignsController < Admin::AdminController
  before_action :find_design
  before_action :find_banner, only: :edit
  before_action :find_banner_link, only: :edit
  before_action :find_style_snippets, only: :edit

  def edit
  end

  def update
    if @design.update_attributes(design_params)
      redirect_to admin_root_path, notice: "Design successfully updated."
    else
      find_banner
      find_banner_link
      find_style_snippets
      render :edit
    end
  end

  private

  def find_design
    @design = Design.first
  end

  def find_banner
    @banner = @design.banner || @design.build_banner
  end

  def find_banner_link
    @banner_link = @banner.link || @banner.build_link
  end

  def find_style_snippets
    @style_snippets = Snippet.grouped_by_extension(:css, :scss)
  end

  def design_params
    params.require(:design).permit(
      :theme, :display_font, :body_font, :scss,
      { color_scheme_attributes: [*ColorScheme::COLOR_ATTRIBUTES, :id] },
      :background_image, :background_image_cache, :remove_background_image,
      { banner_attributes: [:image, :image_cache, :full_screen, :id, :_destroy,
        link_attributes: [:external_url, :page_id, :id]] },
      :logo, :logo_cache, :remove_logo,
      :favicon, :favicon_cache, :remove_favicon
    )
  end

end