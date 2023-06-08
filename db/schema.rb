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

ActiveRecord::Schema[7.0].define(version: 2023_06_07_182226) do
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

  add_foreign_key "immunotherapies", "patients"
  add_foreign_key "patch_forms", "patients"
  add_foreign_key "patch_measurements", "patch_forms"
  add_foreign_key "patch_measurements", "patch_sensitizer_infos"
  add_foreign_key "patch_sensitizer_infos", "patch_test_infos"
end
