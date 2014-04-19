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

ActiveRecord::Schema.define(version: 20140415172121) do

  create_table "bodylogs", force: true do |t|
    t.float    "weight"
    t.integer  "kcal"
    t.float    "bodyfat"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cardio_segments", force: true do |t|
    t.integer  "time"
    t.integer  "intensity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cardio_id"
  end

  create_table "cardios", force: true do |t|
    t.string   "name"
    t.integer  "intensity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "workout_id"
    t.integer  "user_id"
  end

  create_table "contact_forms", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", force: true do |t|
    t.string   "name"
    t.integer  "workout_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "strength"
  end

  create_table "profiles", force: true do |t|
    t.integer  "age"
    t.integer  "height"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "caltarget"
    t.float    "weighttarget"
    t.integer  "activity"
    t.integer  "gender"
    t.float    "changerate"
  end

  create_table "segments", force: true do |t|
    t.float    "weight"
    t.integer  "reps"
    t.integer  "intensity"
    t.integer  "exercise_id"
    t.integer  "workout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "strength"
    t.integer  "pr"
  end

  create_table "settings", force: true do |t|
    t.string   "var",         null: false
    t.text     "value"
    t.integer  "target_id",   null: false
    t.string   "target_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "workouts", force: true do |t|
    t.string   "name"
    t.string   "comment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rating"
  end

end
