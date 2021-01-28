class MenuItemsController < ApplicationController
  before_action :ensure_user_is_owner

  def edit
    id = params[:id]
    @menu_item = MenuItem.find_by(id: id)
    render "menus/edit_menuitem"
  end

  def update
    id = params[:id]
    name = params[:name]
    desc = params[:desc]
    price = params[:price].to_d

    menu_item = MenuItem.find_by(id: id)
    menu_item.name = name
    menu_item.description = desc
    menu_item.price = price.to_d
    menu_item.save!

    redirect_to all_menus_path
  end

  def create
    menu_id = params[:id]
    name = params[:name]
    desc = params[:desc]
    price = params[:price].to_d
    menu = Menu.find_by(id: menu_id)
    menu.menu_items.create!(name: name, description: desc, price: price)
    redirect_to all_menus_path
  end

  def delete
    id = params[:id].to_i
    menu_item = MenuItem.find_by(id: id)
    menu_item.destroy!
    redirect_to all_menus_path
  end
end
