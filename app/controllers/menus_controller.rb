class MenusController < ApplicationController
  before_action :ensure_user_is_owner, except: [:index]

  def index
    @menu = Menu.active_menu
    if !(@menu)
      flash[:error] = "There are no menu available at the moment."
      redirect_to "/"
    else
      render "index"
    end
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
    @menus = Menu.all.order(:id)
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

  def update
    menu_id = params[:id].to_i

    if menu_id <= 0
      redirect_to all_menus_path
      return
    end

    if !Menu.update_active_status(menu_id)
      flash[:error] = "Can not update menu at the moment"
    end
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
