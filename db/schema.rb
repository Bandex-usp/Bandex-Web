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

ActiveRecord::Schema.define(version: 20151005152331) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "line_statuses", force: :cascade do |t|
    t.datetime "submit_date"
    t.integer  "status"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "line_statuses", ["restaurant_id"], name: "index_line_statuses_on_restaurant_id", using: :btree

  create_table "menu_entries", force: :cascade do |t|
    t.date     "entry_date"
    t.integer  "period"
    t.integer  "restaurant_id"
    t.string   "main"
    t.string   "meat"
    t.string   "second"
    t.string   "salad"
    t.string   "optional"
    t.string   "desert"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "raw"
  end

  add_index "menu_entries", ["restaurant_id"], name: "index_menu_entries_on_restaurant_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "line_statuses", "restaurants"
  add_foreign_key "menu_entries", "restaurants"
end
