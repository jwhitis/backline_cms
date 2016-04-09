Feature::NAMES.each do |name|
  Feature.find_or_create_by!(name: name)
end

unless Site.exists?(subdomain: "www")
  site_attributes = { title: "Backline CMS", subdomain: "www" }
  site = SiteCreator.new(site_attributes, features: false, pages: false).create!
  home_page = DefaultPage.create!(title: "Admin", slug: "admin", site: site)
  site.update_attributes!(home_page_id: home_page.id)
end

unless Site.exists?(subdomain: "demo")
  SiteCreator.new(title: "Demo Site", subdomain: "demo").create!
end

User.create_with(
  password: "password",
  password_confirmation: "password",
  super_admin: true
).find_or_create_by!(email: "admin@backlinecms.com")