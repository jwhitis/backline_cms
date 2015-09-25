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

DefaultPage::SLUGS.each do |slug|
  page = DefaultPage.create_with(title: slug.titleize).find_or_create_by!(slug: slug)
  page.create_nav_link!(text: page.title) unless page.nav_link
  page.feature ||= Feature.find_by_name!(slug)
  page.save!
end

homepage = Page.published.order(:created_at).first
site = Site.create_with(title: "New Site", homepage_id: homepage.id).first_or_create!
site.features << Feature.unactivated