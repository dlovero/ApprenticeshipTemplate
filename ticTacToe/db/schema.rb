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

ActiveRecord::Schema.define(version: 20161012192625) do

  create_table "boards", force: :cascade do |t|
    t.integer "player_x_id", null: false
    t.integer "player_o_id", null: false
    t.integer "turn"
    t.string  "winner"
  end

  create_table "squares", force: :cascade do |t|
    t.integer "x"
    t.integer "y"
    t.string  "mark"
    t.integer "board_id"
  end

  create_table "users", force: :cascade do |t|
    t.string  "username"
    t.integer "board_id"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
