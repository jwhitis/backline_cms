Feature::NAMES.each do |name|
  Feature.find_or_create_by!(name: name)
end

Site.first || SiteCreator.new(title: "New Site").create!

User.create_with(
  password: "password",
  password_confirmation: "password",
  super_admin: true
).find_or_create_by!(email: "admin@backlinecms.com")