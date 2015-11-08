# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151108132725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "title",                        null: false
    t.date     "release_date",                 null: false
    t.text     "notes"
    t.string   "bandcamp_url"
    t.string   "itunes_url"
    t.string   "cover_art",                    null: false
    t.boolean  "published",    default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "tracks_count", default: 0,     null: false
    t.string   "archive"
  end

  create_table "color_schemes", force: :cascade do |t|
    t.string   "background", null: false
    t.string   "foreground", null: false
    t.string   "accent",     null: false
    t.string   "text",       null: false
    t.integer  "design_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "color_schemes", ["design_id"], name: "index_color_schemes_on_design_id", using: :btree

  create_table "designs", force: :cascade do |t|
    t.string   "background_image"
    t.string   "banner_image"
    t.string   "logo"
    t.string   "favicon"
    t.integer  "site_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "theme",            null: false
    t.string   "display_font",     null: false
    t.string   "body_font",        null: false
    t.text     "scss"
    t.text     "css"
  end

  add_index "designs", ["site_id"], name: "index_designs_on_site_id", using: :btree

  create_table "feature_activations", force: :cascade do |t|
    t.integer  "site_id",    null: false
    t.integer  "feature_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "feature_activations", ["feature_id", "site_id"], name: "index_feature_activations_on_feature_id_and_site_id", unique: true, using: :btree
  add_index "feature_activations", ["feature_id"], name: "index_feature_activations_on_feature_id", using: :btree
  add_index "feature_activations", ["site_id"], name: "index_feature_activations_on_site_id", using: :btree

  create_table "features", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "features", ["name"], name: "index_features_on_name", unique: true, using: :btree

  create_table "nav_links", force: :cascade do |t|
    t.string   "text",         null: false
    t.string   "external_url"
    t.integer  "position",     null: false
    t.integer  "page_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "nav_links", ["page_id"], name: "index_nav_links_on_page_id", using: :btree
  add_index "nav_links", ["text"], name: "index_nav_links_on_text", unique: true, using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title",                        null: false
    t.string   "slug",                         null: false
    t.text     "html"
    t.boolean  "published",                    null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "scss"
    t.text     "css"
    t.text     "javascript"
    t.string   "type",                         null: false
    t.boolean  "blank_layout", default: false, null: false
    t.integer  "feature_id"
  end

  add_index "pages", ["feature_id"], name: "index_pages_on_feature_id", using: :btree
  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "photos", force: :cascade do |t|
    t.text     "caption"
    t.string   "image"
    t.boolean  "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shows", force: :cascade do |t|
    t.string   "venue_name", limit: 255
    t.date     "date"
    t.string   "cover",      limit: 255
    t.string   "address",    limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.string   "zip",        limit: 255
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time",       limit: 255
    t.boolean  "published"
    t.string   "venue_url"
  end

  create_table "sites", force: :cascade do |t|
    t.integer  "home_page_id",       null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "title",              null: false
    t.text     "description"
    t.integer  "splash_page_id"
    t.text     "subscriber_message"
  end

  add_index "sites", ["home_page_id"], name: "index_sites_on_home_page_id", using: :btree
  add_index "sites", ["splash_page_id"], name: "index_sites_on_splash_page_id", using: :btree

  create_table "subscribers", force: :cascade do |t|
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.string   "zip"
  end

  add_index "subscribers", ["email"], name: "index_subscribers_on_email", unique: true, using: :btree

  create_table "tracks", force: :cascade do |t|
    t.string   "title",                        null: false
    t.integer  "position",                     null: false
    t.integer  "album_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "type",                         null: false
    t.string   "audio"
    t.boolean  "downloadable", default: false, null: false
  end

  add_index "tracks", ["album_id"], name: "index_tracks_on_album_id", using: :btree

  create_table "tweets", force: :cascade do |t|
    t.string   "handle",      limit: 255
    t.string   "image_url",   limit: 255
    t.text     "text"
    t.datetime "posted_at"
    t.integer  "twitter_id",  limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "profile_url"
  end

  create_table "twitter_handles", force: :cascade do |t|
    t.string   "handle",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "caption"
    t.text     "embed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
  end

  add_foreign_key "color_schemes", "designs"
  add_foreign_key "designs", "sites"
  add_foreign_key "feature_activations", "features"
  add_foreign_key "feature_activations", "sites"
  add_foreign_key "nav_links", "pages"
  add_foreign_key "pages", "features"
  add_foreign_key "sites", "pages", column: "home_page_id"
  add_foreign_key "sites", "pages", column: "splash_page_id"
  add_foreign_key "tracks", "albums"
end
