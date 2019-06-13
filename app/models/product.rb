class Product < ApplicationRecord
  has_many :accessory_products
  has_many :accessories, through: :accessory_products, dependent: :destroy
  has_many :order_item_products
  has_many :order_items, through: :order_item_products, dependent: :destroy
  has_many :related_items
  has_many :order_items, through: :related_items, dependent: :destroy

  def destroy
    self.deleted_at = DateTime.now
  end
end