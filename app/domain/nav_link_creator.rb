class NavLinkCreator
  TEXT_MAP = { "exclusive-content" => nil }

  def initialize page
    @page = page
  end

  def create!
    return true if text.nil?

    @page.create_nav_link!(text: text)
  end

  private

  def text
    TEXT_MAP.fetch(@page.slug, @page.title)
  end

end