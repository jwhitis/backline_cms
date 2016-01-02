class Role < ActiveRecord::Base
  ADMIN_NAMES = %w(site_admin site_editor)
  NAMES = ADMIN_NAMES + %w(basic)

  belongs_to :user
  belongs_to :site

  validates :name, presence: true, inclusion: { in: NAMES }
  validates_presence_of :user_id
  validates :site_id, presence: true, uniqueness: { scope: :user_id }
end
