class MenusController < ApplicationController
  before_action :ensure_user_is_owner, except: [:index]
  def index
    @menu = Menu.first
    render "index"
  end

  def show
    id = params[:id].to_i

    if id <= 0
      return
    end

    @menu = Menu.find_by_id(id)
    render "menus/index"
  end

  def show_all
    @menus = Menu.all
    render "all"
  end

  def new
    render "new"
  end

  def create
    items = params[:menu_item]
    menu_name = params[:name]
    Menu.create_menu(menu_name, items)
    redirect_to all_menus_path
  end

  def menuitem_create
    name = params[:name]
    desc = params[:desc]
    price = params[:price].to_d


  end

  def menuitem_edit
    id = params[:id].to_i

    if id <= 0
      return
    end

    @menu_item = MenuItem.find_by_id(id)

    render "edit_menuitem"
  end

  def menuitem_update
    id = params[:id].to_i
    name = params[:name]
    desc = params[:desc]
    price = params[:price].to_d

    if id <= 0
      return
    end

    menu_item = MenuItem.find_by_id(id)

    menu_item.name = name
    menu_item.description = desc
    menu_item.price = price.to_d

    menu_item.save

    redirect_to all_menus_path
  end

  def menuitem_additem
    menu_id = params[:id].to_i

    name = params[:name]
    desc = params[:desc]
    price = params[:price].to_d



    if menu_id <= 0
      return
    end

    menu = Menu.find_by_id(menu_id)

    menu.menu_items.create!(name: name, description: desc, price: price)
    redirect_to all_menus_path
  end

  def menuitem_delete
    id = params[:id].to_i
    name = params[:name]
    desc = params[:desc]
    price = params[:price].to_d

    if id <= 0
      return
    end

    menu_item = MenuItem.find_by_id(id)

    menu_item.destroy

    redirect_to all_menus_path
  end



  def destroy
    id = params[:id].to_i

    if id <= 0
      return
    end

    menu = Menu.find_by_id(id)

    menu.destroy
    redirect_to all_menus_path
  end
end
