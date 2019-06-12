class Product < ApplicationRecord
  has_many :accessory_products
  has_many :accessories, through: :accessory_product
end