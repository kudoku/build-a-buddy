class CreateCategoryProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :category_products, primary_key: [:category_id, :product_id] do |t|
      t.belongs_to :product
      t.belongs_to :category
    end
  end
end
