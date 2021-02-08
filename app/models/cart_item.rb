class CartItem < ApplicationRecord
  belongs_to :cart
  validates :menu_item_name, presence: true
  validates :menu_item_quantity, presence: true
  validates :menu_item_price, presence: true

  def self.create_items(item_id, item_info)
    existing_item = find_by(menu_item_id: item_id)
    if existing_item
      quantity = (existing_item.menu_item_quantity == nil) ? 0 : existing_item.menu_item_quantity
      price = (existing_item.menu_item_price == nil) ? 0 : existing_item.menu_item_price

      existing_item.menu_item_quantity = quantity + item_info[:quantity].to_i
      existing_item.menu_item_price = price + (item_info[:quantity].to_i * item_info[:price].to_d)
      return existing_item.save
    else
      item = new(menu_item_id: item_id, menu_item_name: item_info[:name], menu_item_quantity: item_info[:quantity].to_i, menu_item_price: (item_info[:price].to_d * item_info[:quantity].to_i))
      if item.save
        return true
      else
        return false
      end
    end
  end
end
