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

ActiveRecord::Schema.define(version: 20160127185116) do

  create_table "entrants", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "idnumber"
    t.string   "dog_name"
    t.string   "dogidnumber"
    t.string   "breed"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "entrants_events", id: false, force: :cascade do |t|
    t.integer "entrant_id"
    t.integer "event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "division"
    t.integer  "int_search_areas"
    t.integer  "veh_search_areas"
    t.integer  "ext_search_areas"
    t.integer  "cont_search_areas"
    t.integer  "elite_search_areas"
    t.integer  "int_hides"
    t.integer  "veh_hides"
    t.integer  "ext_hides"
    t.integer  "cont_hides"
    t.integer  "elite_hides"
    t.string   "place"
    t.date     "date"
    t.string   "host"
    t.string   "status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "scorecards", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "entrant_scd_id"
    t.integer  "hides_found"
    t.integer  "hides_missed"
    t.integer  "maxpoint"
    t.integer  "hides_max"
    t.integer  "other_faults_count"
    t.integer  "search_area"
    t.integer  "total_faults"
    t.integer  "total_points"
    t.string   "absent"
    t.string   "element"
    t.string   "dismissed"
    t.string   "eliminated_during_search"
    t.string   "excused"
    t.integer  "false_alert_fringe"
    t.string   "finish_call"
    t.string   "judge_signature"
    t.string   "maxtime_m"
    t.string   "maxtime_s"
    t.string   "maxtime_ms"
    t.string   "name"
    t.string   "pronounced"
    t.string   "timed_out"
    t.string   "time_elapsed_m"
    t.string   "time_elapsed_s"
    t.string   "time_elapsed_ms"
    t.text     "comments"
    t.text     "other_faults_descr"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "scorecards", ["event_id"], name: "index_scorecards_on_event_id"

  create_table "tallies", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "total_time_m"
    t.string   "total_time_s"
    t.string   "total_time_ms"
    t.integer  "entrant_tly_id"
    t.integer  "total_faults"
    t.integer  "total_points"
    t.string   "title"
    t.integer  "qualifying_score"
    t.integer  "qualifying_scores"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "tallies", ["event_id"], name: "index_tallies_on_event_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.string   "status"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
