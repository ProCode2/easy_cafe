class MenuItem < ApplicationRecord
  belongs_to :menu

  def self.get_item_info(items)
    items_info ={}
    items.each do |(name, quantity)|
      item = find_by(name: name)
      if !item
        return
      end

      items_info[name] ={
        :id => item.id,
        :price => item.price,
        :quantity => quantity,
      }
    end

    return items_info

  end
  def tods
    "#{name} desc: #{description}"
  end
end
