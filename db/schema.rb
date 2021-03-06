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

ActiveRecord::Schema.define(version: 20160506200624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointment_skills", force: :cascade do |t|
    t.integer  "appointment_id", null: false
    t.integer  "skill_id",       null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "datetime",   null: false
    t.integer  "mentor_id"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "appointments", ["mentor_id"], name: "index_appointments_on_mentor_id", using: :btree
  add_index "appointments", ["student_id"], name: "index_appointments_on_student_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating",         null: false
    t.string   "content",        null: false
    t.integer  "author_id",      null: false
    t.integer  "appointment_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "phone",           null: false
    t.string   "password_digest", null: false
    t.string   "phase",           null: false
    t.string   "type",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
