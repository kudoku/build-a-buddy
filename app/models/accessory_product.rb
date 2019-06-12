class AccessoryProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :accessory
end