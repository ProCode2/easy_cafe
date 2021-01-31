class OrdersController < ApplicationController
  before_action :ensure_user_is_clerk, only: [:show_all]

  def index
    @orders = current_user.orders ? current_user.orders.all : []
    render "index"
  end

  def show_all
    @orders = Order.all
    @all = true
    render "index"
  end

  def show
    id = params[:id].to_i

    if id <= 0
      return
    end

    if current_user.owner? || current_user.clerk?
      @order = Order.find_by(id: id)
    else
      @order = current_user.orders.find_by(id: id)
    end
    render "order"
  end

  def create
    # create an order
    result = Order.create_order(current_user)
    if result[:error]
      flash[:error] = result[:error]
      redirect_to carts_path
    else
      flash[:success] = "Succesfully placed your order."
      redirect_to "/orders/#{result[:order].id}"
    end
  end

  def update
    id = params[:id].to_i

    if id <= 0
      return
    end

    order = Order.find_by(id: id)
    if params[:completed] == "1"
      order.delivered_at = Date.today;
    else
      order.delivered_at = nil;
    end

    if order.save
      redirect_to manage_orders_path
    else
      flash[:error] = "Can not update the status of the order."
      redirect_to manage_orders_path
    end
  end
end
