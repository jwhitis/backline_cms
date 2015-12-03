class DefaultPageCreator
  TITLE_MAP = {}
  FEATURE_NAME_MAP = { "exclusive-content" => "mailing_list" }

  def initialize slug
    @slug = slug
  end

  def first_or_create!
    DefaultPage.find_by_slug(@slug) || DefaultPage.create!(attributes)
  end

  private

  def attributes
    {
      slug: @slug,
      title: title,
      feature: feature
    }
  end

  def title
    TITLE_MAP.fetch(@slug, @slug.titleize)
  end

  def feature
    name = FEATURE_NAME_MAP.fetch(@slug, @slug)
    Feature.find_by_name(name)
  end

end