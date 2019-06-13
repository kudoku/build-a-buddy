class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.belongs_to  :order, foreign_key: true
      t.decimal :total, precision: 8, scale: 2

      t.timestamps
    end
  end
end
