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

ActiveRecord::Schema.define(version: 20161022160015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "donations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "storage_unit_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.string   "last_name"
    t.string   "telephone"
  end

  add_index "donations", ["storage_unit_id"], name: "index_donations_on_storage_unit_id", using: :btree
  add_index "donations", ["user_id"], name: "index_donations_on_user_id", using: :btree

  create_table "extraction_products", force: :cascade do |t|
    t.integer  "product_type_id"
    t.integer  "extraction_id"
    t.float    "required_quantity", default: 0.0
    t.float    "received_quantity", default: 0.0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "extraction_products", ["extraction_id"], name: "index_extraction_products_on_extraction_id", using: :btree
  add_index "extraction_products", ["product_type_id"], name: "index_extraction_products_on_product_type_id", using: :btree

  create_table "extractions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "storage_unit_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.string   "last_name"
    t.string   "telephone"
  end

  add_index "extractions", ["storage_unit_id"], name: "index_extractions_on_storage_unit_id", using: :btree
  add_index "extractions", ["user_id"], name: "index_extractions_on_user_id", using: :btree

  create_table "fav_storage_units", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "storage_unit_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "fav_storage_units", ["storage_unit_id"], name: "index_fav_storage_units_on_storage_unit_id", using: :btree
  add_index "fav_storage_units", ["user_id"], name: "index_fav_storage_units_on_user_id", using: :btree

  create_table "product_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "expiration_time"
    t.string   "measurement_unit"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "product_type_id"
    t.float    "quantity",        default: 0.0
    t.date     "expiration_date"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "donation_id"
    t.integer  "storage_unit_id"
    t.string   "label"
    t.string   "code"
  end

  add_index "products", ["donation_id"], name: "index_products_on_donation_id", using: :btree
  add_index "products", ["product_type_id"], name: "index_products_on_product_type_id", using: :btree
  add_index "products", ["storage_unit_id"], name: "index_products_on_storage_unit_id", using: :btree

  create_table "storage_unit_managers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "storage_unit_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "storage_unit_managers", ["storage_unit_id"], name: "index_storage_unit_managers_on_storage_unit_id", using: :btree
  add_index "storage_unit_managers", ["user_id"], name: "index_storage_unit_managers_on_user_id", using: :btree

  create_table "storage_units", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "telephone"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "service_time_from"
    t.string   "service_time_to"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.string   "last_name"
    t.string   "telephone"
    t.boolean  "manager",                default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "donations", "storage_units"
  add_foreign_key "donations", "users"
  add_foreign_key "extraction_products", "extractions"
  add_foreign_key "extraction_products", "product_types"
  add_foreign_key "extractions", "storage_units"
  add_foreign_key "extractions", "users"
  add_foreign_key "fav_storage_units", "storage_units"
  add_foreign_key "fav_storage_units", "users"
  add_foreign_key "products", "donations"
  add_foreign_key "products", "product_types"
  add_foreign_key "products", "storage_units"
  add_foreign_key "storage_unit_managers", "storage_units"
  add_foreign_key "storage_unit_managers", "users"
end
