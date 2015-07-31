class NavLink < ActiveRecord::Base
  include Orderable

  belongs_to :page

  validates :text, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :external_url, url: true, allow_blank: true
  validate :external_url_or_page_must_be_present

  before_validation :set_page

  def external_url_or_page_must_be_present
    unless self.external_url.present? || self.page
      self.errors[:base] << "You must choose a page or enter a URL"
    end
  end

  def set_page
    self.page = nil if self.external_url.present?
    true # Object becomes invalid if a callback returns false
  end

  def url
    if self.external_url.present?
      self.external_url
    elsif self.page
      "/#{self.page.slug}"
    end
  end

end
