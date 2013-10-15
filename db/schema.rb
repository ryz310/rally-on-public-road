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

ActiveRecord::Schema.define(version: 20131015072507) do

  create_table "check_points", force: true do |t|
    t.integer  "event_id",                 null: false
    t.integer  "number",     default: 1,   null: false
    t.float    "latitude",   default: 0.0, null: false
    t.float    "longitude",  default: 0.0, null: false
    t.text     "note",       default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "check_points", ["event_id"], name: "index_check_points_on_event_id"

  create_table "prefectures", force: true do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rally_car_events", force: true do |t|
    t.string   "name",         default: "", null: false
    t.date     "beginning_on",              null: false
    t.date     "end_on",                    null: false
    t.text     "note",         default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_rally_car_events", force: true do |t|
    t.integer  "user_id",                   null: false
    t.integer  "event_id",                  null: false
    t.date     "beginning_on",              null: false
    t.date     "end_on"
    t.text     "note",         default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",          default: "", null: false
    t.date     "birthday"
    t.integer  "prefecture_id"
    t.text     "profile",       default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["prefecture_id"], name: "index_users_on_prefecture_id"

  create_table "vehicles", force: true do |t|
    t.integer  "user_id",                       null: false
    t.string   "name",             default: "", null: false
    t.date     "acquisition_date"
    t.text     "profile",          default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vehicles", ["user_id"], name: "index_vehicles_on_user_id"

end
