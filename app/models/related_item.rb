class RelatedItem < ApplicationRecord
  belongs_to :order_item
  belongs_to :product
end