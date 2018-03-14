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

ActiveRecord::Schema.define(version: 20180308153525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "products", force: :cascade do |t|
    t.string "asin", null: false
    t.text "category"
    t.bigint "rank"
    t.decimal "item_width"
    t.decimal "item_height"
    t.decimal "item_length"
    t.text "item_width_units"
    t.text "item_height_units"
    t.text "item_length_units"
    t.decimal "package_width"
    t.decimal "package_height"
    t.decimal "package_length"
    t.text "package_width_units"
    t.text "package_height_units"
    t.text "package_length_units"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asin"], name: "index_products_on_asin", unique: true
  end

end
