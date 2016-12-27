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

ActiveRecord::Schema.define(version: 20161227023544) do

  create_table "attachments", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "user_id",             limit: 4
    t.string   "file_path",           limit: 255
    t.string   "file_content_type",   limit: 255
    t.integer  "file_size",           limit: 4
    t.integer  "attachmentable_id",   limit: 4
    t.string   "attachmentable_type", limit: 255
    t.datetime "deleted_at"
    t.text     "remark",              limit: 65535
    t.string   "sub_type",            limit: 255
    t.integer  "order_user_id",       limit: 4
    t.string   "order_user_type",     limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "attachments", ["attachmentable_id", "attachmentable_type"], name: "index_attachments_on_attachmentable_id_and_attachmentable_type", using: :btree
  add_index "attachments", ["deleted_at"], name: "index_attachments_on_deleted_at", using: :btree
  add_index "attachments", ["order_user_id"], name: "index_attachments_on_user_id", using: :btree
  add_index "attachments", ["order_user_type", "order_user_id"], name: "index_attachments_on_order_user_type_and_order_user_id", using: :btree

  create_table "evaluations", force: :cascade do |t|
    t.integer  "evaluatable_id",   limit: 4
    t.string   "evaluatable_type", limit: 255
    t.integer  "types",            limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id",          limit: 4
  end

  create_table "meal_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "store_id",    limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "status",      limit: 4
    t.integer  "meals_count", limit: 4,   default: 0
  end

  create_table "meals", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.float    "price",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mtype",      limit: 4
  end

  create_table "operation_logs", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "action",        limit: 255
    t.string   "loggable_type", limit: 255
    t.integer  "loggable_id",   limit: 4
    t.text     "note",          limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "operation_logs", ["action"], name: "index_operation_logs_on_action", using: :btree
  add_index "operation_logs", ["loggable_id"], name: "index_operation_logs_on_loggable_id", using: :btree
  add_index "operation_logs", ["loggable_type"], name: "index_operation_logs_on_loggable_type", using: :btree
  add_index "operation_logs", ["user_id"], name: "index_operation_logs_on_user_id", using: :btree

  create_table "order_users", force: :cascade do |t|
    t.string   "uname",      limit: 255
    t.integer  "role",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",     limit: 1,   default: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "meal_id",    limit: 4
    t.integer  "num",        limit: 4
    t.integer  "Subtotal",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
    t.integer  "status",     limit: 4
  end

  create_table "shops", force: :cascade do |t|
    t.string   "sname",               limit: 255
    t.datetime "begin_time"
    t.datetime "end_time"
    t.boolean  "status",              limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "remember_order_time"
  end

  create_table "talks", force: :cascade do |t|
    t.text     "content",      limit: 65535
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "meal_type_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               limit: 255
    t.string   "pinyin",                 limit: 255
    t.string   "phone",                  limit: 255
    t.integer  "status",                 limit: 4,   default: 0
    t.string   "deleted_at",             limit: 255
    t.string   "truename",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "role",                   limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
