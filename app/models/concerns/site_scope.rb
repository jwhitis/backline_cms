module SiteScope
  extend ActiveSupport::Concern

  included do
    # The default scope is not applied to new records if it is
    # defined as a class method.
    default_scope do
      Site.current_id ? where(site_id: Site.current_id) : all
    end
  end

end