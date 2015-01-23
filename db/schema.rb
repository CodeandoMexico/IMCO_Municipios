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

ActiveRecord::Schema.define(version: 20150120204017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dependencies", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "municipio_id"
  end

  add_index "dependencies", ["municipio_id"], name: "index_dependencies_on_municipio_id", using: :btree

  create_table "formation_steps", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.string   "type"
    t.text     "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "municipio_id"
  end

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
    t.string   "nombre"
    t.string   "materia"
    t.string   "duracion"
    t.text     "norma"
    t.text     "antes"
    t.text     "durante"
    t.text     "despues"
    t.text     "sancion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dependency_id"
  end

  create_table "inspectors", force: true do |t|
    t.string   "nombre"
    t.string   "vigencia"
    t.string   "materia"
    t.string   "supervisor"
    t.string   "contacto"
    t.string   "foto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dependency_id"
  end

  create_table "lines", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "municipio_id"
  end

  create_table "municipios", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "nombre"
    t.string   "duracion"
    t.string   "costo"
    t.string   "vigencia"
    t.string   "contacto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dependency_id"
    t.text     "tipo"
  end

  create_table "requirements", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "path"
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
    t.integer  "municipio_id"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["municipio_id"], name: "index_users_on_municipio_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
