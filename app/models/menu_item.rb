class MenuItem < ApplicationRecord
  belongs_to :menu

  def self.get_item_info(items)
    items_info = {}
    items.each do |(item_id, quantity)|
      item = find_by(id: item_id)
      if !item
        return
      end

      items_info[item.id] = {
        :name => item.name,
        :price => item.price,
        :quantity => quantity,
      }
    end
    return items_info
  end
end
