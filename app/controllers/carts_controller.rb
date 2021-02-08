class CartsController < ApplicationController
  def index
    @cart = (current_user.cart) ? current_user.cart.cart_items.all.order(:id) : []
    render "index"
  end

  def create
    filtered_params = params[:menu_items].select { |key, value| value != "" }

    items_info = MenuItem.get_item_info(filtered_params)

    # create cart record
    result = Cart.create_cart(current_user, items_info)

    if result[:error]
      flash[:error] = result[:error]
      redirect_to menus_path
      return
    end
    redirect_to carts_path
  end

  def destroy
    id = params[:id].to_i
    if id < 0
      return
    end

    item = current_user.cart.cart_items.find_by(id: id)
    item_status = item.destroy
    if item_status.destroyed?
      redirect_to carts_path
    else
      flash[:error] = "Can not delete Item from cart at the moment."
      redirect_to carts_path
    end
  end
end
