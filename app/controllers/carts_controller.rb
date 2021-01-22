class CartsController < ApplicationController

  def index
    @cart = current_user.cart.cart_items.all.order(:id)
    render "index"
  end

  def create
    filtered_params = params[:menu_items].select {|key, value| value != "" }

    items_info = MenuItem.get_item_info(filtered_params)

    # create cart record
    cart = Cart.create_cart(current_user)
    result = items_info.map do |(item_name, item_info)|
      cart.cart_items.create_items(item_name, item_info)
    end

    redirect_to carts_path
  end

  def destroy
    id = params[:id].to_i
    if id < 0
      return
    end

    item = current_user.cart.cart_items.find_by_id(id)
    item_status = item.destroy
    if item_status.destroyed?
      redirect_to carts_path
    else
      redirect_to carts_path
    end
  end
end
