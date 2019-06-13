class Order < ApplicationRecord
  has_many :order_items
  has_many :order_item_products, through: :order_items
end