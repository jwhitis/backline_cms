class NavLink < ActiveRecord::Base
  include Orderable

  belongs_to :page

  validates :text, presence: true, uniqueness: true
  validates_presence_of :url
end
