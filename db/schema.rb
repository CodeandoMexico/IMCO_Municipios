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

ActiveRecord::Schema.define(version: 20151019203652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: true do |t|
    t.text     "name"
    t.text     "address"
    t.text     "phone"
    t.text     "schedule"
    t.integer  "user_id"
    t.integer  "city_id"
    t.string   "operation_license"
    t.text     "operation_license_file"
    t.text     "land_permission_file"
    t.integer  "line_id"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "using",                  default: false
  end

  create_table "cat_twitters", force: true do |t|
    t.text     "state"
    t.text     "town"
    t.text     "twitter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "contact_email"
    t.decimal  "latitude",                  precision: 10, scale: 6
    t.decimal  "longitude",                 precision: 10, scale: 6
    t.text     "privacy_file"
    t.text     "contact_phone"
    t.text     "regulations_path"
    t.text     "construction_file"
    t.text     "land_file"
    t.text     "business_file"
    t.boolean  "activated",                                          default: false
    t.string   "dependency_file"
    t.string   "line_file"
    t.string   "formation_step_file"
    t.string   "requirement_file"
    t.string   "procedure_file"
    t.string   "inspection_file"
    t.string   "inspector_file"
    t.boolean  "has_federal_documentation",                          default: true
    t.boolean  "has_state_documentation",                            default: true
  end

  create_table "complaints", force: true do |t|
    t.string   "reason"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.string   "custom_reason"
    t.integer  "user_id"
  end

  create_table "dependencies", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
  end

  add_index "dependencies", ["city_id"], name: "index_dependencies_on_city_id", using: :btree

  create_table "formation_steps", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.string   "type_formation_step"
    t.text     "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.text     "type_of_procedure"
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "inspection_lines", force: true do |t|
    t.integer  "inspection_id"
    t.integer  "line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inspection_requirements", force: true do |t|
    t.integer  "inspection_id"
    t.integer  "requirement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inspections", force: true do |t|
    t.text     "name"
    t.text     "matter"
    t.text     "duration"
    t.text     "rule"
    t.text     "before"
    t.text     "during"
    t.text     "after"
    t.text     "sanction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dependency_id"
    t.text     "certification"
  end

  create_table "inspectors", force: true do |t|
    t.text     "name"
    t.text     "validity"
    t.text     "matter"
    t.text     "supervisor"
    t.text     "contact"
    t.text     "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dependency_id"
  end

  create_table "lines", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
  end

  create_table "procedure_lines", force: true do |t|
    t.integer  "procedure_id"
    t.integer  "line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "procedure_requirements", force: true do |t|
    t.integer  "procedure_id"
    t.integer  "requirement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "procedures", force: true do |t|
    t.text     "name"
    t.text     "long"
    t.text     "cost"
    t.text     "validity"
    t.text     "contact"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dependency_id"
    t.text     "type_procedure"
    t.text     "category"
    t.text     "sare"
  end

  create_table "reminders", force: true do |t|
    t.text     "name"
    t.text     "license"
    t.date     "until_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "business_id"
    t.integer  "frequency"
    t.integer  "frequency_count"
  end

  create_table "requirements", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "path"
    t.integer  "city_id"
  end

  create_table "uploads", force: true do |t|
    t.integer  "id_user"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_formation_steps", force: true do |t|
    t.integer  "formation_step_id"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "line_id"
    t.string   "type_user_formation_step"
  end

  create_table "user_procedures", force: true do |t|
    t.integer  "business_id"
    t.integer  "procedure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_requirements", force: true do |t|
    t.integer  "business_id"
    t.integer  "requirement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "name"
    t.integer  "city_id"
    t.boolean  "is_super_user",          default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
