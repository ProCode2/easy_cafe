class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user

  def self.creat_order(current_user)
    current_user.orders.create!(user_id: current_user.id, date: Date.today())
  end

  def create_order_items(current_user)
    # copy cart items to order items
    current_user.cart.cart_items.each do |item|
      OrderItem.create!(
        order_id: id,
        menu_item_id: item.menu_item_id,
        menu_item_name: item.menu_item_name,
        menu_item_price: item.menu_item_price,
        menu_item_quantity: item.menu_item_quantity
      )
    end
    current_user.cart.destroy
  end
end
