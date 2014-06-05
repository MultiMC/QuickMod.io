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

ActiveRecord::Schema.define(version: 20140605002031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "quickmods", force: true do |t|
    t.string   "uid"
    t.string   "name"
    t.text     "description"
    t.string   "tags",        array: true
    t.string   "categories",  array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "quickmods", ["slug"], name: "index_quickmods_on_slug", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.integer  "quickmod_id"
    t.string   "name"
    t.string   "version_type"
    t.string   "mc_compat",                 array: true
    t.string   "forge_compat"
    t.integer  "download_type", default: 0
    t.integer  "install_type",  default: 0
    t.string   "md5"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["quickmod_id"], name: "index_versions_on_quickmod_id", using: :btree

end
