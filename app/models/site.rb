class Site < ActiveRecord::Base
  cattr_accessor :current_id

  has_many :feature_activations, dependent: :destroy
  has_many :features, through: :feature_activations
  has_many :roles, dependent: :destroy
  has_one :design, dependent: :destroy

  validates_presence_of :title
  validates_presence_of :home_page_id, on: :update
  validates :subdomain, presence: true, subdomain: true, uniqueness: { case_sensitive: false }
  validate :referenced_pages_must_be_published
  validate :referenced_pages_must_not_have_exclusive_content
  validate :home_page_must_not_belong_to_inactive_feature
  validate :home_page_must_not_have_blank_layout
  validate :splash_page_must_have_blank_layout

  before_validation :format_subdomain

  delegate :background_image_url, :banner_image_url, :logo_url, :favicon_url,
           *Design.color_methods, :display_font, :body_font, :css, to: :design

  def referenced_pages_must_be_published
    [:home_page_id, :splash_page_id].each do |attribute|
      page_id = self.send(attribute)
      next unless page = Page.find_by_id(page_id)

      unless page.published?
        self.errors.add(attribute, "must be a published page")
      end
    end
  end

  def referenced_pages_must_not_have_exclusive_content
    [:home_page_id, :splash_page_id].each do |attribute|
      page_id = self.send(attribute)
      next unless page = Page.find_by_id(page_id)

      if page.exclusive_content?
        self.errors.add(attribute, "must not have exclusive content")
      end
    end
  end

  def home_page_must_not_belong_to_inactive_feature
    return unless home_page = Page.find_by_id(self.home_page_id)
    return unless feature = Feature.find_by_id(home_page.feature_id)

    if self.feature_activations.where(feature: feature).empty?
      self.errors.add(:home_page_id, "must not belong to an inactive feature")
    end
  end

  def home_page_must_not_have_blank_layout
    return unless home_page = Page.find_by_id(self.home_page_id)

    if home_page.blank_layout?
      self.errors.add(:home_page_id, "must not have a blank layout")
    end
  end

  def splash_page_must_have_blank_layout
    return unless splash_page = Page.find_by_id(self.splash_page_id)

    unless splash_page.blank_layout?
      self.errors.add(:splash_page_id, "must have a blank layout")
    end
  end

  def format_subdomain
    if self.new_record? || self.subdomain_changed?
      text = [self.subdomain, self.title].find(&:present?) || ""
      self.subdomain = text.gsub("_", "-").parameterize
    end
  end

  def home_page
    @home_page ||= Page.find(self.home_page_id)
  end

  def splash_page
    return @splash_page if defined?(@splash_page)
    @splash_page = Page.find_by_id(self.splash_page_id)
  end

  def feature_names
    @feature_names ||= self.features.pluck(:name)
  end

  def reload options = nil
    @home_page = nil
    remove_instance_variable(:@splash_page) if defined?(@splash_page)
    @feature_names = nil
    super
  end

  def self.with_twitter_feed
    feature = Feature.find_by_name!("twitter_feed")
    joins(:feature_activations).where(feature_activations: { feature_id: feature.id })
  end

end
