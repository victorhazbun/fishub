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

ActiveRecord::Schema.define(version: 2018_07_11_164624) do

  create_table "baits", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_baits_on_name", unique: true
  end

  create_table "catches", force: :cascade do |t|
    t.string "species"
    t.decimal "weight"
    t.decimal "length"
    t.integer "bait_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bait_id"], name: "index_catches_on_bait_id"
    t.index ["user_id"], name: "index_catches_on_user_id"
  end

  create_table "tackle_box_items", force: :cascade do |t|
    t.integer "bait_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bait_id"], name: "index_tackle_box_items_on_bait_id"
    t.index ["user_id"], name: "index_tackle_box_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "catches", "baits"
  add_foreign_key "catches", "users"
  add_foreign_key "tackle_box_items", "baits"
  add_foreign_key "tackle_box_items", "users"
end
