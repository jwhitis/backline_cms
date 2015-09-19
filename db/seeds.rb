# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DefaultPage::SLUGS.each do |slug|
  page = DefaultPage.create_with(title: slug.titleize, published: true).
                     find_or_create_by!(slug: slug)
  page.create_nav_link!(text: page.title) unless page.nav_link
end

homepage = Page.published.order(:created_at).first
Site.create_with(title: "New Site", homepage_id: homepage.id).first_or_create!