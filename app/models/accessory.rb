class Accessory < ApplicationRecord
  has_many :accessory_products
  has_many :products, through: :accessory_product

  # enum size: [:small, :medium, :large, :all]
end