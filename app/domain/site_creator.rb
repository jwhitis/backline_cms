class SiteCreator

  def initialize attributes
    @attributes = attributes
  end

  def create
    Site.transaction do
      @site = Site.create(@attributes)
      return @site unless @site.persisted?

      create_dependencies!
    end
  end

  def create!
    Site.transaction do
      @site = Site.create!(@attributes)
      create_dependencies!
    end
  end

  private

  def create_dependencies!
    Site.current_id = @site.id

    @site.features << Feature.inactive

    DefaultPage::SLUGS.each do |slug|
      page = DefaultPageCreator.new(slug).create!
      NavLinkCreator.new(page).create!
    end

    home_page = DefaultPage.first
    @site.update_attributes!(home_page_id: home_page.id)

    design = Design.create!
    design.create_color_scheme!

    @site
  ensure
    Site.current_id = nil
  end

end