class OrderItem < ApplicationRecord
  belongs_to :order

  def self.sales_uptil_today
    total_sales_price = all.sum(:menu_item_price)
  end

  def self.create_order_items(current_user)
    # copy cart items to order items
    current_user.cart.cart_items.each do |item|
      OrderItem.create!(
        menu_item_id: item.menu_item_id,
        menu_item_name: item.menu_item_name,
        menu_item_price: item.menu_item_price,
        menu_item_quantity: item.menu_item_quantity,
      )
    end
    current_user.cart.destroy
  end
end
