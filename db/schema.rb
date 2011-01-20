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

ActiveRecord::Schema.define(:version => 20110120021229) do

  create_table "characters", :force => true do |t|
    t.string   "region",             :limit => 2
    t.string   "realm"
    t.string   "name",               :limit => 12
    t.string   "battlegroup"
    t.string   "guild",              :limit => 24
    t.integer  "achievement_points"
    t.integer  "level"
    t.integer  "title_id"
    t.integer  "faction_id"
    t.integer  "race_id"
    t.integer  "class_id"
    t.integer  "gender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "characters", ["region", "realm", "name"], :name => "index_characters_on_region_and_realm_and_name", :unique => true

end
