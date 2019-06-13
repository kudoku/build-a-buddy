class CreateAccessories < ActiveRecord::Migration[5.2]
  def change
    create_table :accessories do |t|
      t.decimal :price, precision: 8, scale: 2
      t.decimal :cost, precision: 8, scale: 2
      t.string :name
      t.string :description
      t.integer :quantity, default: 0
      t.string :size

      t.datetime :deleted_at
      t.timestamps
    end

    add_index :accessories, [:name, :size], unique: true
  end
end
