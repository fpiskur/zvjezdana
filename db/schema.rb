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

ActiveRecord::Schema[7.0].define(version: 2022_06_20_110009) do
  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_num"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_name"], name: "index_clients_on_last_name"
  end

  create_table "treatments", force: :cascade do |t|
    t.date "date"
    t.text "description"
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id", "date"], name: "index_treatments_on_client_id_and_date"
    t.index ["client_id"], name: "index_treatments_on_client_id"
  end

  add_foreign_key "treatments", "clients"
end
