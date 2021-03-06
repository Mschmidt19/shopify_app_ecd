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

ActiveRecord::Schema.define(version: 2018_10_17_005723) do

  create_table "products", force: :cascade do |t|
    t.integer "shopify_id", null: false
    t.string "title", null: false
    t.string "shopify_created_at"
    t.string "shopify_updated_at"
    t.string "shopify_published_at"
    t.text "body_html"
    t.string "handle"
    t.string "product_type"
    t.text "tags"
    t.string "vendor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.integer "shopify_id", null: false
    t.integer "shopify_product_id"
    t.string "title"
    t.string "shopify_created_at"
    t.string "shopify_updated_at"
    t.string "price"
    t.string "sku"
    t.string "option1"
    t.string "option2"
    t.string "option3"
    t.integer "position"
    t.boolean "taxable"
    t.float "weight"
    t.string "weight_unit"
    t.integer "inventory_quantity"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

end
