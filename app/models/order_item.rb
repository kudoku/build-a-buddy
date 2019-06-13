class OrderItem < ApplicationRecord
  belongs_to :order
  has_many :order_item_products
  has_many :products, through: :order_item_products, dependent: :destroy
  has_many :related_items
  has_many :products, through: :related_items
end