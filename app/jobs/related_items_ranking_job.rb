class RelatedItemsRankingJob < ApplicationJob
  queue_as :default
 
  def perform(*args)
    # create related items based on todays ordered items
    ActiveRecord::Base.transaction do
      Order.includes(order_items: :products).where(created_at: DateTime.now.beginning_of_day()..DateTime.now.end_of_day()) do |order|
        order.order_items.each do |order_item|
          order_item.products.pluck(:id).each do |p_id|
            RelatedItem.create(product_id: p_id, order_item_id: order_item.id)
          end
        end
      end
    end
  end
end