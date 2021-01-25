class Menu < ApplicationRecord
  has_many :menu_items, dependent: :destroy

  def self.create_menu(name, items)
    menu = create!(name: name)
    items.keys.each do |key|
      menu.menu_items.create!(name: items[key][:name], description: items[key][:desc], price: items[key][:price].to_d)
    end
  end

  def self.update_active_status(menu_id)
    prev_menu = find_by(active: true)
    if prev_menu
      prev_menu.active = false
      prev_menu.save
    end
    menu = find_by_id(menu_id)
    menu.active = true
    menu.save
  end

  def self.active_menu
    find_by(active: true)
  end
end
