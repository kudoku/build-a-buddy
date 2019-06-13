class CreateRelatedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :related_items do |t|
      t.belongs_to  :order_item
      t.belongs_to  :product
      t.integer      :rank
    end
  end
end
