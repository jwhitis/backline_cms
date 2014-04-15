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

ActiveRecord::Schema.define(version: 20140415030333) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shows", force: true do |t|
    t.string   "venue"
    t.date     "date"
    t.string   "cover"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time"
    t.boolean  "published"
  end

  create_table "tweets", force: true do |t|
    t.string   "screen_name"
    t.string   "profile_image_url"
    t.text     "text"
    t.datetime "posted_at"
    t.integer  "twitter_id",        limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "title"
    t.text     "caption"
    t.text     "embed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
  end

end
