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

ActiveRecord::Schema.define(version: 20160914194026) do

  create_table "books", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.string   "isbn"
    t.float    "price"
  end

  create_table "cart_sessions", force: :cascade do |t|
    t.datetime "last_time_used"
    t.integer  "cart_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
  end

  add_index "cart_sessions", ["cart_id"], name: "index_cart_sessions_on_cart_id"

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sale_id"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "credit_card_owner"
    t.string   "credit_card_number"
    t.date     "expiration_date"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id",            null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer "cart_id"
    t.integer "book_id"
    t.integer "amount_of_books"
    t.integer "sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "credit_card_id"
    t.float    "total_price"
    t.integer  "items"
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
