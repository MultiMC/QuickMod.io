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

ActiveRecord::Schema.define(version: 20140605211520) do

  create_table "authors", force: true do |t|
    t.integer  "quickmod_id"
    t.string   "role"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.integer "quickmod_id"
    t.string  "category"
  end

  create_table "downloadurls", force: true do |t|
    t.integer "version_id"
    t.string  "url"
    t.string  "download_type"
  end

  create_table "quickmods", force: true do |t|
    t.string   "uid"
    t.string   "repo"
    t.string   "name"
    t.string   "mod_id"
    t.text     "description"
    t.text     "license"
    t.string   "tags"
    t.string   "categories"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "quickmods", ["repo"], name: "index_quickmods_on_repo"
  add_index "quickmods", ["slug"], name: "index_quickmods_on_slug", unique: true
  add_index "quickmods", ["uid"], name: "index_quickmods_on_uid"

  create_table "references", force: true do |t|
    t.integer "version_id"
    t.string  "uid"
    t.string  "version"
    t.string  "reference_type"
  end

  create_table "tags", force: true do |t|
    t.integer "quickmod_id"
    t.string  "tag"
  end

  create_table "urls", force: true do |t|
    t.integer  "quickmod_id"
    t.string   "type"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "versions", force: true do |t|
    t.integer  "quickmod_id"
    t.string   "name"
    t.string   "version"
    t.string   "version_type"
    t.string   "install_type"
    t.string   "sha1"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "versions", ["quickmod_id"], name: "index_versions_on_quickmod_id"

end
