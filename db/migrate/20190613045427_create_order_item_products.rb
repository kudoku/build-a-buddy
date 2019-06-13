class CreateOrderItemProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_item_products, primary_key: [:order_item_id, :product_id] do |t|
      t.belongs_to  :order_item
      t.belongs_to  :product
    end
  end
end
