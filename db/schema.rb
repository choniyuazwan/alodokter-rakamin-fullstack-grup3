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

ActiveRecord::Schema.define(version: 2021_12_19_113116) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.bigint "category_id", null: false
    t.string "content"
    t.string "image"
    t.bigint "reviewer_id", null: false
    t.boolean "headline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["reviewer_id"], name: "index_articles_on_reviewer_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "doc_spe_ins_day_hou_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doc_spe_ins_day_hou_id"], name: "index_bookings_on_doc_spe_ins_day_hou_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "days", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "doc_spe_ins", force: :cascade do |t|
    t.bigint "doc_spe_id", null: false
    t.bigint "institution_id", null: false
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doc_spe_id"], name: "index_doc_spe_ins_on_doc_spe_id"
    t.index ["institution_id"], name: "index_doc_spe_ins_on_institution_id"
  end

  create_table "doc_spe_ins_day_hous", force: :cascade do |t|
    t.bigint "doc_spe_ins_day_id", null: false
    t.bigint "hour_id", null: false
    t.date "date"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doc_spe_ins_day_id"], name: "index_doc_spe_ins_day_hous_on_doc_spe_ins_day_id"
    t.index ["hour_id"], name: "index_doc_spe_ins_day_hous_on_hour_id"
  end

  create_table "doc_spe_ins_days", force: :cascade do |t|
    t.bigint "doc_spe_in_id", null: false
    t.bigint "day_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["day_id"], name: "index_doc_spe_ins_days_on_day_id"
    t.index ["doc_spe_in_id"], name: "index_doc_spe_ins_days_on_doc_spe_in_id"
  end

  create_table "doc_spes", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "specialization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_doc_spes_on_doctor_id"
    t.index ["specialization_id"], name: "index_doc_spes_on_specialization_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hours", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviewers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "specializations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "fullname"
    t.date "birthdate"
    t.string "gender"
    t.string "phone"
    t.string "identity"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "reviewers"
  add_foreign_key "bookings", "doc_spe_ins_day_hous"
  add_foreign_key "bookings", "users"
  add_foreign_key "doc_spe_ins", "doc_spes"
  add_foreign_key "doc_spe_ins", "institutions"
  add_foreign_key "doc_spe_ins_day_hous", "doc_spe_ins_days"
  add_foreign_key "doc_spe_ins_day_hous", "hours"
  add_foreign_key "doc_spe_ins_days", "days"
  add_foreign_key "doc_spe_ins_days", "doc_spe_ins"
  add_foreign_key "doc_spes", "doctors"
  add_foreign_key "doc_spes", "specializations"
end
