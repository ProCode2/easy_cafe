class MenusController < ApplicationController
  def index
    @menu = Menu.find_by_id(1)
    render "index"
  end
end
