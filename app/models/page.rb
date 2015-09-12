class Page < ActiveRecord::Base
  has_one :nav_link, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true, slug: true, uniqueness: true

  def self.display_order
    order(created_at: :desc)
  end

  def self.published
    where(published: true)
  end

  def self.editable
    where(editable: true)
  end

  def self.uneditable
    where(editable: false)
  end

end
