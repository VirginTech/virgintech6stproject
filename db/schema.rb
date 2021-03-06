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

ActiveRecord::Schema.define(version: 20160304050736) do

  create_table "admin_notices", force: :cascade do |t|
    t.date     "release_date"
    t.string   "subject",      limit: 255
    t.text     "notice_body",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "comment_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "bookmarks", ["comment_id"], name: "index_bookmarks_on_comment_id", using: :btree
  add_index "bookmarks", ["user_id", "comment_id"], name: "index_bookmarks_on_user_id_and_comment_id", unique: true, using: :btree
  add_index "bookmarks", ["user_id"], name: "index_bookmarks_on_user_id", using: :btree

  create_table "comment_replies", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "user_comment_id", limit: 4
    t.text     "reply_comment",   limit: 65535
    t.string   "image",           limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "comment_replies", ["user_comment_id"], name: "index_comment_replies_on_user_comment_id", using: :btree
  add_index "comment_replies", ["user_id"], name: "index_comment_replies_on_user_id", using: :btree

  create_table "dev_comments", force: :cascade do |t|
    t.integer  "developer_id", limit: 4
    t.integer  "product_id",   limit: 4
    t.text     "comment",      limit: 65535
    t.string   "image",        limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "dev_comments", ["developer_id"], name: "index_dev_comments_on_developer_id", using: :btree
  add_index "dev_comments", ["product_id"], name: "index_dev_comments_on_product_id", using: :btree

  create_table "developers", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "profile_img",     limit: 255
    t.boolean  "status"
    t.text     "profile",         limit: 65535
    t.string   "website",         limit: 255
    t.string   "twitter",         limit: 255
    t.string   "facebook",        limit: 255
    t.string   "google",          limit: 255
    t.string   "official_site",   limit: 255
    t.string   "contact_email",   limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "developers", ["email"], name: "index_developers_on_email", unique: true, using: :btree
  add_index "developers", ["name"], name: "index_developers_on_name", unique: true, using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "product_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "favorites", ["product_id"], name: "index_favorites_on_product_id", using: :btree
  add_index "favorites", ["user_id", "product_id"], name: "index_favorites_on_user_id_and_product_id", unique: true, using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

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
    t.integer  "developer_id",       limit: 4
    t.string   "appname",            limit: 255
    t.text     "summary",            limit: 65535
    t.text     "description",        limit: 65535
    t.integer  "category",           limit: 4
    t.integer  "price",              limit: 4
    t.boolean  "model_iphone"
    t.boolean  "model_android"
    t.boolean  "model_web"
    t.string   "img_icon",           limit: 255
    t.string   "img_screenshot_01",  limit: 255
    t.string   "img_screenshot_02",  limit: 255
    t.string   "img_screenshot_03",  limit: 255
    t.string   "img_screenshot_04",  limit: 255
    t.string   "img_screenshot_05",  limit: 255
    t.date     "sale_date"
    t.string   "store_iphone_url",   limit: 255
    t.string   "store_android_url",  limit: 255
    t.string   "store_webgame_url",  limit: 255
    t.string   "official_site",      limit: 255
    t.string   "twitter",            limit: 255
    t.string   "facebook",           limit: 255
    t.string   "etc_site",           limit: 255
    t.string   "youtube_url",        limit: 255
    t.text     "update_info",        limit: 65535
    t.text     "operating_notes",    limit: 65535
    t.text     "how_to_play",        limit: 65535
    t.text     "features_cheats",    limit: 65535
    t.text     "history_of_develop", limit: 65535
    t.text     "word_to_user",       limit: 65535
    t.text     "finally_something",  limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
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

  create_table "user_comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "product_id", limit: 4
    t.text     "comment",    limit: 65535
    t.string   "image",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "user_comments", ["product_id"], name: "index_user_comments_on_product_id", using: :btree
  add_index "user_comments", ["user_id"], name: "index_user_comments_on_user_id", using: :btree

  create_table "user_follows", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "user_follows", ["followed_id"], name: "index_user_follows_on_followed_id", using: :btree
  add_index "user_follows", ["follower_id", "followed_id"], name: "index_user_follows_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "user_follows", ["follower_id"], name: "index_user_follows_on_follower_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "nickname",          limit: 255
    t.string   "email",             limit: 255
    t.string   "password_digest",   limit: 255
    t.string   "provider",          limit: 255
    t.string   "uid",               limit: 255
    t.string   "profile_img",       limit: 255
    t.boolean  "status"
    t.text     "profile",           limit: 65535
    t.boolean  "product_mail_info"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree

end
