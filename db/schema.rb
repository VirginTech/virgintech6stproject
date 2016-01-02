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

ActiveRecord::Schema.define(version: 20160102085352) do

  create_table "developers", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "profile_img",     limit: 255
    t.boolean  "status"
    t.string   "website",         limit: 255
    t.string   "twitter",         limit: 255
    t.string   "facebook",        limit: 255
    t.string   "google",          limit: 255
    t.string   "official_site",   limit: 255
    t.string   "contact_email",   limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "developers", ["email"], name: "index_developers_on_email", unique: true, using: :btree
  add_index "developers", ["name"], name: "index_developers_on_name", unique: true, using: :btree

  create_table "pass_dev_tokens", force: :cascade do |t|
    t.integer  "developer_id", limit: 4,   null: false
    t.string   "uuid",         limit: 255, null: false
    t.datetime "expired_at",               null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "pass_dev_tokens", ["developer_id"], name: "index_pass_dev_tokens_on_developer_id", using: :btree

  create_table "pass_user_tokens", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,   null: false
    t.string   "uuid",       limit: 255, null: false
    t.datetime "expired_at",             null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "pass_user_tokens", ["user_id"], name: "index_pass_user_tokens_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "developer_id",      limit: 4
    t.string   "appname",           limit: 255
    t.text     "summary",           limit: 65535
    t.text     "description",       limit: 65535
    t.integer  "category",          limit: 4
    t.integer  "price",             limit: 4
    t.boolean  "model_iphone"
    t.boolean  "model_android"
    t.boolean  "model_web"
    t.string   "img_icon",          limit: 255
    t.string   "img_screenshot_01", limit: 255
    t.string   "img_screenshot_02", limit: 255
    t.string   "img_screenshot_03", limit: 255
    t.string   "img_screenshot_04", limit: 255
    t.string   "img_screenshot_05", limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "products", ["developer_id", "created_at"], name: "index_products_on_developer_id_and_created_at", using: :btree
  add_index "products", ["developer_id"], name: "index_products_on_developer_id", using: :btree

  create_table "regist_dev_tokens", force: :cascade do |t|
    t.integer  "developer_id", limit: 4,   null: false
    t.string   "uuid",         limit: 255, null: false
    t.datetime "expired_at",               null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "regist_dev_tokens", ["developer_id"], name: "index_regist_dev_tokens_on_developer_id", using: :btree

  create_table "regist_user_tokens", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,   null: false
    t.string   "uuid",       limit: 255, null: false
    t.datetime "expired_at",             null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "regist_user_tokens", ["user_id"], name: "index_regist_user_tokens_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "nickname",        limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "provider",        limit: 255
    t.string   "uid",             limit: 255
    t.string   "profile_img",     limit: 255
    t.boolean  "status"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree

end
