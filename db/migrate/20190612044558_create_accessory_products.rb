class CreateAccessoryProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :accessory_products, primary_key: [:product_id, :accessory_id] do |t|
      t.belongs_to :product
      t.belongs_to :accessory
    end
  end
end
