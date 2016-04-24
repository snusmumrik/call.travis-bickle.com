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

ActiveRecord::Schema.define(version: 20160424055950) do

  create_table "orders", force: :cascade do |t|
    t.integer  "parent_id",    limit: 4
    t.integer  "user_id",      limit: 4
    t.string   "address",      limit: 255
    t.float    "latitude",     limit: 24
    t.float    "longitude",    limit: 24
    t.integer  "amount",       limit: 4
    t.datetime "time"
    t.string   "keyword",      limit: 255
    t.string   "device_token", limit: 255
    t.datetime "assigned_at"
    t.datetime "picked_up_at"
    t.datetime "arrived_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "orders_person_in_charges", force: :cascade do |t|
    t.integer  "order_id",            limit: 4
    t.integer  "person_in_charge_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.datetime "deleted_at"
  end

  add_index "orders_person_in_charges", ["order_id"], name: "index_orders_person_in_charges_on_order_id", using: :btree
  add_index "orders_person_in_charges", ["person_in_charge_id"], name: "index_orders_person_in_charges_on_person_in_charge_id", using: :btree

  create_table "orders_taxis", force: :cascade do |t|
    t.integer  "order_id",   limit: 4
    t.integer  "taxi_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.datetime "deleted_at"
  end

  add_index "orders_taxis", ["taxi_id"], name: "index_orders_taxis_on_taxi_id", using: :btree

  create_table "person_in_charges", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "deleted_at"
  end

  add_index "person_in_charges", ["user_id"], name: "index_person_in_charges_on_user_id", using: :btree

  create_table "taxis", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.string   "type_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "deleted_at"
  end

  add_index "taxis", ["user_id"], name: "index_taxis_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "parent_id",              limit: 4
    t.string   "name",                   limit: 255, default: "", null: false
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
    t.string   "authentication_token",   limit: 255
    t.boolean  "admin"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.datetime "deleted_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "orders", "users"
  add_foreign_key "orders_person_in_charges", "orders"
  add_foreign_key "orders_person_in_charges", "person_in_charges"
  add_foreign_key "orders_taxis", "taxis"
  add_foreign_key "person_in_charges", "users"
  add_foreign_key "taxis", "users"
end
