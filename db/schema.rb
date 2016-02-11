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
    t.integer  "int_search_areas",   default: 0
    t.integer  "veh_search_areas",   default: 0
    t.integer  "ext_search_areas",   default: 0
    t.integer  "cont_search_areas",  default: 0
    t.integer  "elite_search_areas", default: 0
    t.integer  "int_hides",          default: 0
    t.integer  "veh_hides",          default: 0
    t.integer  "ext_hides",          default: 0
    t.integer  "cont_hides",         default: 0
    t.integer  "elite_hides",        default: 0
    t.string   "place"
    t.date     "date"
    t.string   "host"
    t.string   "status"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "scorecards", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "entrant_scd_id"
    t.integer  "hides_found",                                      default: 0
    t.decimal  "hides_missed",                                     default: 0.0
    t.float    "maxpoint"
    t.integer  "hides_max",                                        default: 0
    t.integer  "other_faults_count",                               default: 0
    t.integer  "search_area"
    t.integer  "total_faults"
    t.decimal  "total_points",             precision: 5, scale: 2
    t.string   "absent",                                           default: "no"
    t.string   "element"
    t.string   "dismissed",                                        default: "no"
    t.string   "eliminated_during_search",                         default: "no"
    t.string   "excused",                                          default: "no"
    t.integer  "false_alert_fringe",                               default: 0
    t.string   "finish_call",                                      default: "yes"
    t.string   "judge_signature",                                  default: "no"
    t.string   "maxtime_m",                                        default: "00"
    t.string   "maxtime_s",                                        default: "00"
    t.string   "maxtime_ms",                                       default: "00"
    t.string   "name"
    t.string   "pronounced",                                       default: "no"
    t.string   "timed_out"
    t.string   "time_elapsed_m",                                   default: "00"
    t.string   "time_elapsed_s",                                   default: "00"
    t.string   "time_elapsed_ms",                                  default: "00"
    t.text     "comments"
    t.text     "other_faults_descr"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
  end

  add_index "scorecards", ["event_id"], name: "index_scorecards_on_event_id"

  create_table "tallies", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "total_time_m",                              default: "00"
    t.string   "total_time_s",                              default: "00"
    t.string   "total_time_ms",                             default: "00"
    t.integer  "entrant_tly_id"
    t.integer  "total_faults",                              default: 0
    t.decimal  "total_points",      precision: 5, scale: 2
    t.string   "title"
    t.integer  "qualifying_score",                          default: 0
    t.integer  "qualifying_scores",                         default: 0
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  add_index "tallies", ["event_id"], name: "index_tallies_on_event_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.string   "approved"
    t.string   "status"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
