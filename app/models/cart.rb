class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  belongs_to :user

  def self.create_cart(current_user, items_info)
    if items_info.keys.length == 0
      return {
               :error => "Not enough items to add in cart.",
             }
    end
    current_user.cart = Cart.find_or_create_by!(user_id: current_user.id)
    result = items_info.map do |(item_id, item_info)|
      current_user.cart.cart_items.create_items(item_id, item_info)
    end

    return {
             :success => result,
           }
  end

  def self.get_total_price(cart_items)
    cart_items.inject(0) { |sum, item| sum += item.menu_item_price.to_d }
  end
end
