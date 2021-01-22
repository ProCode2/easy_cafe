class CartsController < ApplicationController

  def index
    @cart = current_user.cart.cart_items.all
    render "index"
  end

  def create
    filtered_params = params[:menu_items].select {|key, value| value != "" }

    items_info = MenuItem.get_item_info(filtered_params)

    # create cart record
    cart = Cart.create_cart(current_user)
    result = items_info.map do |(item_name, item_info)|
      cart.cart_items.create!(menu_item_id: item_info[:id], menu_item_name: item_name, menu_item_price: (item_info[:price].to_d * item_info[:quantity].to_i))
    end

    render plain: result
  end
end
