class Site < ActiveRecord::Base
  has_many :feature_activations, dependent: :destroy
  has_many :features, through: :feature_activations
  has_one :design, dependent: :destroy

  validates_presence_of :title, :home_page_id
  validate :referenced_pages_must_be_published
  validate :home_page_must_not_have_blank_layout
  validate :splash_page_must_have_blank_layout

  delegate :background_image_url, :banner_image_url, to: :design

  def referenced_pages_must_be_published
    [:home_page_id, :splash_page_id].each do |attribute|
      next unless page_id = self.send(attribute)

      unless Page.find(page_id).published?
        self.errors.add(attribute, "must be a published page")
      end
    end
  end

  def home_page_must_not_have_blank_layout
    if Page.find(self.home_page_id).blank_layout?
      self.errors.add(:home_page_id, "must not have a blank layout")
    end
  end

  def splash_page_must_have_blank_layout
    return unless self.splash_page_id

    unless Page.find(self.splash_page_id).blank_layout?
      self.errors.add(:splash_page_id, "must have a blank layout")
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

end
