class Accessory < ApplicationRecord
  has_many :accessory_products
  has_many :products, through: :accessory_product

  has_many :order_item_accessories
  has_many :order_items, through: :order_item_accessories

  # enum size: [:small, :medium, :large, :all]
end