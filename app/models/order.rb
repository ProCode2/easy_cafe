class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user

  def self.create_order(current_user)
    if !(current_user.cart) or (current_user.cart.cart_items.count == 0)
      return {
        :error => "Your Cart is empty, add items to your cart first."
      }
    end
    order = current_user.orders.new(user_id: current_user.id, date: Date.today())

    if order.save
      order.create_order_items(current_user)
      return {
        :order => order
      }
    else
      return {
        :error => "Can not create order at the moment."
      }
    end
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

  def self.all_orders
    all
  end

  def user_name
    User.find_by_id(user_id).name
  end

  def self.get_all_orders_in(from, to , user_id = current_user.id)
    user = User.find_by_id(user_id)

    if user
      if !from or !to
        return {
          :orders => user.orders.all
        }
      else
        return {
          :orders => user.orders.where("created_at >= ? and created_at <= ?", from, to)
        }
      end
    else
      return {
        :error => "User could not be found."
        }
    end
  end

  def get_total_price
    order_items.all.inject(0) { |sum, item| sum += item.menu_item_price.to_d }
  end
end
