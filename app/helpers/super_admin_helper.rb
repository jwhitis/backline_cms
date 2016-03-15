module SuperAdminHelper

  def super_admin_nav_links
    [
      ["Users", super_admin_users_path, "users"],
      ["Sites", super_admin_sites_path, "globe"]
    ]
  end

end