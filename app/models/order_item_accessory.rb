class OrderItemAccessory < ApplicationRecord
  belongs_to :order_item
  belongs_to :accessory
end