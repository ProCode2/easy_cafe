class MenusController < ApplicationController
  def index
    render plain: Menu.all.first.menu_items.map{ |item| "#{item.tods}" }.join("\n")
  end
end
