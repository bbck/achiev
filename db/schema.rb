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

ActiveRecord::Schema.define(:version => 20110904195815) do

  create_table "characters", :force => true do |t|
    t.string   "region",             :limit => 2,  :null => false
    t.string   "realm",                            :null => false
    t.string   "name",               :limit => 12, :null => false
    t.string   "battlegroup"
    t.integer  "guild_id"
    t.integer  "achievement_points"
    t.integer  "level"
    t.integer  "title_id"
    t.integer  "faction_id"
    t.integer  "race_id"
    t.integer  "class_id"
    t.integer  "gender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "fetched_at"
  end

  add_index "characters", ["region", "realm", "name"], :name => "index_characters_on_region_and_realm_and_name", :unique => true

  create_table "guilds", :force => true do |t|
    t.string   "region",             :limit => 2,  :null => false
    t.string   "realm",                            :null => false
    t.string   "name",               :limit => 24, :null => false
    t.string   "battlegroup"
    t.integer  "level"
    t.integer  "achievement_points"
    t.integer  "faction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "fetched_at"
    t.integer  "characters_count"
  end

  add_index "guilds", ["region", "realm", "name"], :name => "index_guilds_on_region_and_realm_and_name", :unique => true

end
