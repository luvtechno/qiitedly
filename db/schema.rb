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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121013072758) do

  create_table "search_results", :force => true do |t|
    t.integer  "tag_id"
    t.string   "title"
    t.string   "html_title"
    t.string   "link"
    t.string   "display_link"
    t.text     "snippet"
    t.text     "html_snippet"
    t.string   "cse_thumbnail"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string  "name",                          :null => false
    t.string  "url_name",                      :null => false
    t.string  "icon_url",                      :null => false
    t.integer "item_count",     :default => 0
    t.integer "follower_count", :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "url_name"
    t.string   "profile_image_url"
    t.string   "url"
    t.string   "description"
    t.string   "website_url"
    t.string   "organization"
    t.string   "location"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "twitter"
    t.integer  "followers",         :default => 0
    t.integer  "following_users",   :default => 0
    t.integer  "items",             :default => 0
    t.datetime "fetched_at"
    t.string   "github"
  end

  add_index "users", ["name"], :name => "index_users_on_name"

end
