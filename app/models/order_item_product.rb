class OrderItemProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order_item
end