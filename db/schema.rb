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

ActiveRecord::Schema.define(version: 20150509020200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boutique_searches", force: :cascade do |t|
    t.string   "keywords"
    t.integer  "boutique_id"
    t.string   "boutique_name"
    t.string   "category"
    t.string   "city"
    t.string   "state"
    t.string   "new"
    t.string   "show"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "boutiques", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.text     "schedule"
    t.string   "category"
    t.text     "description"
    t.integer  "owner_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "boutiques", ["owner_id", "created_at"], name: "index_boutiques_on_owner_id_and_created_at", using: :btree
  add_index "boutiques", ["owner_id"], name: "index_boutiques_on_owner_id", using: :btree

  create_table "owners", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "username"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.boolean  "admin",             default: false
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "owners", ["email"], name: "index_owners_on_email", unique: true, using: :btree

  add_foreign_key "boutiques", "owners"
end
