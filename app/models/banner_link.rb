class BannerLink < Link
  belongs_to :banner

  validates_presence_of :banner # This must match the :inverse_of option on the banner#link
  # association to prevent links that belong to new banners from failing validation.
end