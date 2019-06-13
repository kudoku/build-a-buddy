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

ActiveRecord::Schema.define(version: 2019_06_12_210009) do

  create_table "accessories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "price", precision: 8, scale: 2
    t.decimal "cost", precision: 8, scale: 2
    t.string "name"
    t.string "description"
    t.integer "quantity", default: 0
    t.string "size"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "size"], name: "index_accessories_on_name_and_size", unique: true
  end

  create_table "accessory_products", primary_key: ["product_id", "accessory_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "accessory_id", null: false
    t.index ["accessory_id"], name: "index_accessory_products_on_accessory_id"
    t.index ["product_id"], name: "index_accessory_products_on_product_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "category_products", primary_key: ["category_id", "product_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_category_products_on_category_id"
    t.index ["product_id"], name: "index_category_products_on_product_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "parent_product_id"
    t.decimal "price", precision: 8, scale: 2
    t.decimal "cost", precision: 8, scale: 2
    t.string "name"
    t.string "description"
    t.integer "quantity", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_product_id_id"
    t.index ["name"], name: "index_products_on_name"
    t.index ["parent_product_id_id"], name: "index_products_on_parent_product_id_id"
  end

end
