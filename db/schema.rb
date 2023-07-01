# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_30_192621) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "immunotherapies", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.string "ige_total", default: ""
    t.string "ige_specific", default: ""
    t.string "eosinofilos_perc", default: ""
    t.string "eosinofilos_mm", default: ""
    t.string "prick_summary", default: ""
    t.string "patch_summary", default: ""
    t.text "primary_diagnosis", default: ""
    t.text "secondary_diagnosis", default: ""
    t.text "immunotheray_composition", default: ""
    t.text "dilution_volume", default: ""
    t.integer "sublingual_drops", default: 0
    t.string "city", default: ""
    t.date "signature_date", default: "1000-01-01"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "others", default: ""
    t.index ["patient_id"], name: "index_immunotherapies_on_patient_id"
  end

  create_table "patch_forms", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.string "clinic"
    t.date "application"
    t.date "first_measurement"
    t.date "second_measurement"
    t.string "city"
    t.date "signature_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "requester"
    t.index ["patient_id"], name: "index_patch_forms_on_patient_id"
  end

  create_table "patch_measurements", force: :cascade do |t|
    t.string "first"
    t.string "second"
    t.string "result"
    t.bigint "patch_sensitizer_info_id", null: false
    t.bigint "patch_form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patch_form_id"], name: "index_patch_measurements_on_patch_form_id"
    t.index ["patch_sensitizer_info_id"], name: "index_patch_measurements_on_patch_sensitizer_info_id"
  end

  create_table "patch_sensitizer_infos", force: :cascade do |t|
    t.bigint "patch_test_info_id", null: false
    t.string "label"
    t.string "name"
    t.string "option_name"
    t.text "description"
    t.text "first_text"
    t.text "second_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patch_test_info_id"], name: "index_patch_sensitizer_infos_on_patch_test_info_id"
  end

  create_table "patch_test_infos", force: :cascade do |t|
    t.string "identifier"
    t.string "title"
    t.boolean "initial_show"
    t.text "description"
    t.text "application"
    t.text "citation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.date "birthday"
    t.string "cpf"
    t.string "gender"
    t.string "contact"
    t.string "responsable_name"
    t.string "responsable_degree"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "origin"
    t.text "obs"
  end

  create_table "prick_element_infos", force: :cascade do |t|
    t.bigint "prick_test_info_id", null: false
    t.bigint "prick_group_info_id"
    t.string "identifier"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prick_group_info_id"], name: "index_prick_element_infos_on_prick_group_info_id"
    t.index ["prick_test_info_id"], name: "index_prick_element_infos_on_prick_test_info_id"
  end

  create_table "prick_forms", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.string "clinic"
    t.string "city"
    t.string "puncture_time"
    t.string "reading_time"
    t.date "signature_date"
    t.text "comments"
    t.decimal "positive_control1"
    t.decimal "negative_control1"
    t.decimal "positive_control2"
    t.decimal "negative_control2"
    t.decimal "mean_positive_control"
    t.decimal "mean_negative_control"
    t.string "requester"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_prick_forms_on_patient_id"
  end

  create_table "prick_group_infos", force: :cascade do |t|
    t.string "group_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prick_measurements", force: :cascade do |t|
    t.decimal "first"
    t.decimal "second"
    t.decimal "mean"
    t.string "result"
    t.boolean "psd"
    t.bigint "prick_element_info_id", null: false
    t.bigint "prick_form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prick_element_info_id"], name: "index_prick_measurements_on_prick_element_info_id"
    t.index ["prick_form_id"], name: "index_prick_measurements_on_prick_form_id"
  end

  create_table "prick_test_infos", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "immunotherapies", "patients"
  add_foreign_key "patch_forms", "patients"
  add_foreign_key "patch_measurements", "patch_forms"
  add_foreign_key "patch_measurements", "patch_sensitizer_infos"
  add_foreign_key "patch_sensitizer_infos", "patch_test_infos"
  add_foreign_key "prick_element_infos", "prick_group_infos"
  add_foreign_key "prick_element_infos", "prick_test_infos"
  add_foreign_key "prick_forms", "patients"
  add_foreign_key "prick_measurements", "prick_element_infos"
  add_foreign_key "prick_measurements", "prick_forms"
end
