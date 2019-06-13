class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime  :order_date
      t.decimal :total, precision: 8, scale: 2
      t.decimal :subtotal, precision: 8, scale: 2

      t.timestamps
    end
  end
end
