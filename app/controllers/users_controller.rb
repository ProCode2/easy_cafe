class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in, only: [:create, :new]
  before_action :ensure_user_is_owner, only: [:index, :destroy, :clerk_create]

  def index
    @clerks = User.clerks
    @customers = User.customers
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
      user = result[:success]
      add_session(user.id)
      flash[:success] = "Succesfully Registered"
      if user.role == "customer"
        redirect_to menus_path
      elsif user.role == "owner"
        redirect_to users_path
      else
        redirect_to manage_orders_path
      end
    else
      flash[:error] = result[:error]
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
      flash[:success] = "New User created successfully."
      redirect_to users_path
    else
      flash[:error] = "Can not create User at the moment."
      redirect_to users_path
    end
  end


  def destroy
    id = params[:id].to_i
    if id < 0
      return
    end

    result = User.delete_user(id)

    if result
      flash[:success] = "User #{id} deleted successfully."
      redirect_to users_path
    else
      flash[:error] = "Can not delete User #{id} at the moment"
      redirect_to users_path
    end
  end
end
