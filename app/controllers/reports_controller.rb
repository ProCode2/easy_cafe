class ReportsController < ApplicationController
  before_action :ensure_user_is_owner

  def index
    @sales_uptil_today = OrderItem.sales_uptil_today
    @orders = Order.all_orders
    render "index"
  end

  def user_orders
    user_id = params[:user_id].to_i
    from = params[:from_date]
    to = params[:to_date]

    if user_id <= 0
      redirect_to reports_path
      return
    end

    result = Order.get_all_orders_in(from, to, user_id)

    if result[:error]
      flash[:error] = result[:error]
    else
      @orders = result[:orders]
    end
    render "index"
  end
end
