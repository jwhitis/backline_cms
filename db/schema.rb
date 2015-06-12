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

ActiveRecord::Schema.define(version: 20150610044610) do

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
  end

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

  create_table "tracks", force: :cascade do |t|
    t.string   "title",      null: false
    t.integer  "number",     null: false
    t.integer  "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type",       null: false
    t.string   "audio"
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

  add_foreign_key "tracks", "albums"
end
