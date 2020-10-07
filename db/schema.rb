# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_25_103802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "d_meters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "link"
    t.string "doom_lvl_0"
    t.string "doom_lvl_1"
    t.string "doom_lvl_2"
    t.string "doom_lvl_3"
    t.string "doom_lvl_4"
    t.string "doom_lvl_5"
    t.string "doom_lvl_6"
    t.string "doom_lvl_7"
    t.string "doom_lvl_8"
    t.string "doom_lvl_9"
    t.string "doom_lvl_10"
    t.string "doom_lvl_11"
    t.string "doom_lvl_12"
    t.integer "count_days", default: 14
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.boolean "public"
    t.index ["slug"], name: "index_d_meters_on_slug", unique: true
    t.index ["user_id"], name: "index_d_meters_on_user_id"
  end

  create_table "dooms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "d_meter_id", null: false
    t.string "level"
    t.text "text"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["d_meter_id"], name: "index_dooms_on_d_meter_id"
    t.index ["user_id"], name: "index_dooms_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "d_meter_id", null: false
    t.string "uid"
    t.string "email"
    t.boolean "active", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["d_meter_id"], name: "index_invites_on_d_meter_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "doom_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doom_id"], name: "index_likes_on_doom_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.string "username"
    t.boolean "tos_agreement", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "d_meters", "users"
  add_foreign_key "dooms", "d_meters"
  add_foreign_key "dooms", "users"
  add_foreign_key "invites", "d_meters"
  add_foreign_key "likes", "dooms"
  add_foreign_key "likes", "users"
end
