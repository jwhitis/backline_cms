class Link < ActiveRecord::Base
  belongs_to :page

  validates :external_url, url: true, allow_blank: true
  validate :page_or_external_url_must_be_present

  def page_or_external_url_must_be_present
    unless page_or_external_url_present? && page_or_external_url_blank?
      self.errors[:base] << "You must either choose a page or enter a URL"
    end
  end

  def page_or_external_url_present?
    self.page || self.external_url.present?
  end

  def page_or_external_url_blank?
    self.page.nil? || self.external_url.blank?
  end

  def url
    if self.page
      self.page.path
    elsif self.external_url.present?
      self.external_url
    end
  end

end