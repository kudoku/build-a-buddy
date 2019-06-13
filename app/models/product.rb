class Product < ApplicationRecord
  has_many :accessory_products
  has_many :accessories, through: :accessory_products, dependent: :destroy
  has_many :order_item_products
  has_many :order_items, through: :order_item_products, dependent: :destroy
  has_many :related_items
  has_many :related_order_items, through: :related_items, source: :product, dependent: :destroy

  # scope

  def destroy
    self.deleted_at = DateTime.now
  end

  # returns related products+accessory builds generated in related_items_ranking_job
  def suggestions(limit=3)
    # todo: cache query results rails cache/redis,etc
    top_order_build_ids = self.related_order_items.group(['products.id', 'related_items.product_id']).order('related_items.product_id DESC').limit(limit).pluck(:id)
    return OrderItem.includes(products: :accessories).where(order_id: top_order_build_ids).map(&:products)
  end

  def related_budget_builds(budget=50, limit=3)
    # todo: cache query results rails cache/redis,etc
    item_builds = OrderItem.includes(:products, :accessories).where('total <= ?', budget).order(:total).map(&:products).flatten
    return item_builds.sort do |a,b|
      product_a_margin = a.price - a.cost
      accessory_a_margin = a.price - a.cost
      product_a_total_margin = product_a_margin + accessory_a_margin

      product_b_margin = a.price - a.cost
      accessory_b_margin = a.price - a.cost
      product_b_total_margin = product_b_margin + accessory_b_margin

      product_a_total_margin <=> product_b_total_margin
    end
  end
end