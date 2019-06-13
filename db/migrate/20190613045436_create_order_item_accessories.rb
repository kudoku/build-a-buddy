class CreateOrderItemAccessories < ActiveRecord::Migration[5.2]
  def change
    create_table :order_item_accessories, primary_key: [:order_item_id, :accessory_id] do |t|
      t.belongs_to  :order_item
      t.belongs_to  :accessory
    end
  end
end
