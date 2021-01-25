class OrderItem < ApplicationRecord
  belongs_to :order

  def self.sales_uptil_today
    total_sales_price = all.inject(0) { |sum, item| sum += item.menu_item_price }
  end
end
