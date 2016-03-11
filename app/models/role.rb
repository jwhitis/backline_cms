class Role < ActiveRecord::Base
  ADMIN_NAMES = %w(super_admin site_admin site_editor)
  VALID_NAMES = %w(site_admin site_editor basic)
  NAMES = ADMIN_NAMES | VALID_NAMES

  belongs_to :user
  belongs_to :site

  validates :name, presence: true, inclusion: { in: VALID_NAMES }
  validates_presence_of :user # The association name is used to correspond with the
  # :inverse_of option that has been set on the User model. This prevents roles that
  # belong to new users from failing validation.
  validates :site_id, presence: true, uniqueness: { scope: :user_id }
  validate :must_belong_to_current_site

  def must_belong_to_current_site
    unless self.site_id == Site.current_id
      self.errors.add(:site_id, "must be the current site")
    end
  end

end
