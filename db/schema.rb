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

ActiveRecord::Schema.define(version: 2019_06_13_045447) do

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

  create_table "order_item_accessories", primary_key: ["order_item_id", "accessory_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_item_id", null: false
    t.bigint "accessory_id", null: false
    t.index ["accessory_id"], name: "index_order_item_accessories_on_accessory_id"
    t.index ["order_item_id"], name: "index_order_item_accessories_on_order_item_id"
  end

  create_table "order_item_products", primary_key: ["order_item_id", "product_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_item_id", null: false
    t.bigint "product_id", null: false
    t.index ["order_item_id"], name: "index_order_item_products_on_order_item_id"
    t.index ["product_id"], name: "index_order_item_products_on_product_id"
  end

  create_table "order_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id"
    t.decimal "total", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "order_date"
    t.decimal "total", precision: 8, scale: 2
    t.decimal "subtotal", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "related_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_item_id"
    t.bigint "product_id"
    t.integer "rank"
    t.index ["order_item_id"], name: "index_related_items_on_order_item_id"
    t.index ["product_id"], name: "index_related_items_on_product_id"
  end

  add_foreign_key "order_items", "orders"
end
