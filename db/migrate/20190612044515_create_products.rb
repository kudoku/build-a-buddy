class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :parent_product_id
      t.decimal :price, precision: 8, scale: 2
      t.decimal :cost, precision: 8, scale: 2
      t.string :name, index: true, unique: true
      t.string :description
      t.integer :quantity, default: 0

      t.datetime :deleted_at
      t.timestamps
    end

    add_reference :products, :parent_product_id, index: true
  end
end
