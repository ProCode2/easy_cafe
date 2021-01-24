class Menu < ApplicationRecord
  has_many :menu_items, dependent: :destroy

  def self.create_menu(name, items)
    menu = create!(name: name)
    items.keys.each do |key|
      menu.menu_items.create!(name: items[key][:name], description: items[key][:desc], price: items[key][:price].to_d)
    end
  end
end
