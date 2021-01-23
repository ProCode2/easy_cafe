class OrdersController < ApplicationController
  def index
    @orders = current_user.orders ? current_user.orders.all : []
    render "index"
  end

  def show
    id = params[:id].to_i

    if id <= 0
      return
    end

    @order = current_user.orders.find_by_id(id)
    render "order"
  end

  def create
    # create an order
    order = Order.creat_order(current_user)
    # create order items
    order.create_order_items(current_user)
    redirect_to "/orders/#{order.id}"
  end
end
