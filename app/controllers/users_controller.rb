class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in, only: [:create, :new]
  before_action :ensure_user_is_owner, only: [:index, :destroy, :clerk_create]

  def index
    @clerks = User.all.where(role: "clerk")
    @customers = User.all.where(role: nil)
    render "all"

  end

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

  # create a clerk
  def clerk_create
    name = params[:name]
    email = params[:email]
    digest = params[:password]
    result = User.create_user(name, email, digest, "clerk")

    if result[:success]
      redirect_to users_path
    else
      redirect_to users_path
    end
  end


  def destroy
    id = params[:id].to_i
    if id < 0
      return
    end

    user = User.find_by_id(id)
    user.destroy
    redirect_to users_path
  end
end
