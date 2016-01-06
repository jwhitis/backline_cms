# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Feature::NAMES.each do |name|
  Feature.find_or_create_by!(name: name)
end

site = Site.create_with(title: "New Site").first_or_create!
site.features << Feature.inactive

DefaultPage::SLUGS.each do |slug|
  page = DefaultPageCreator.new(slug).first_or_create!
  NavLinkCreator.new(page).first_or_create!
end

home_page = Page.published.order(:created_at).first
site.update_attributes!(home_page_id: home_page.id)

design = site.design || site.create_design!
design.create_color_scheme! unless design.color_scheme

user = User.create_with(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password"
).first_or_create!
user.roles.create_with(name: "site_admin").find_or_create_by!(site: site)