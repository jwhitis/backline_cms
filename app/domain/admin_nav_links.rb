class AdminNavLinks
  class << self
    delegate :url_helpers, to: "Rails.application.routes"

    def for_role name
      unless Role::NAMES.include?(name)
        raise ArgumentError, "#{name} is not a valid role."
      end

      nav_links.select { |link| link.last.include?(name) }
    end

    private

    def nav_links
      [
        ["Pages", url_helpers.admin_pages_path, "file", admin_roles],
        ["Nav", url_helpers.admin_nav_links_path, "list", admin_roles],
        ["Shows", url_helpers.admin_shows_path, "ticket", admin_roles],
        ["Albums", url_helpers.admin_albums_path, "dot-circle-o", admin_roles],
        ["Photos", url_helpers.admin_photos_path, "camera", admin_roles],
        ["Videos", url_helpers.admin_videos_path, "video-camera", admin_roles],
        ["Audio Player", url_helpers.admin_player_tracks_path, "music", admin_roles],
        ["Twitter Feed", url_helpers.admin_twitter_handles_path, "twitter", admin_roles],
        ["Mailing List", url_helpers.admin_subscribers_path, "envelope", %w(site_admin)],
        ["Design", url_helpers.edit_admin_design_path, "paint-brush", admin_roles],
        ["Settings", url_helpers.edit_admin_site_path, "cog", %w(site_admin)]
      ]
    end

    def admin_roles
      Role::ADMIN_NAMES
    end

  end
end