# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Page::DEFAULT_SLUGS.each do |slug|
  page = Page.uneditable.find_or_create_by!(title: slug.titleize, slug: slug)
  page.create_nav_link!(text: page.title) unless page.nav_link
end

homepage = Page.find_by_slug!(Page::DEFAULT_SLUGS.first)
Site.create_with(homepage_id: homepage.id).first_or_create!