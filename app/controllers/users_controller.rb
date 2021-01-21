class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in
  def new
    render "new"
  end

  def create
    name = params[:name]
    email = params[:email]
    digest = params[:password]
    result = User.create_user(name, email, digest)

    if result[:success]
      redirect_to menus_path
    else
      redirect_to new_user_path
    end
  end
end
