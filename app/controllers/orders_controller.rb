class OrdersController < ApplicationController
  def index
    @order = current_user.order ? current_user.order.order_items.all : []
    render "index"
  end

  def create
    # create an order
    order = Order.creat_order(current_user)
    # create order items
    order.create_order_items(current_user)
    redirect_to menus_path
  end
end
