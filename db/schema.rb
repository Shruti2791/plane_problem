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

ActiveRecord::Schema.define(version: 20170501154148) do

  create_table "lanes", force: :cascade do |t|
    t.integer  "row"
    t.integer  "column"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "plane_id"
    t.integer  "number"
  end

  add_index "lanes", ["plane_id"], name: "index_lanes_on_plane_id"

  create_table "planes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seats", force: :cascade do |t|
    t.integer  "lane_id"
    t.integer  "number"
    t.integer  "status",        default: 0
    t.integer  "kind"
    t.integer  "booking_order"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "row"
    t.integer  "column"
  end

  add_index "seats", ["lane_id"], name: "index_seats_on_lane_id"

end
