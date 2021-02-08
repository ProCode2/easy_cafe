class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "new"
  end

  def create
    email = params[:email]
    user = User.find_by(email: email)
    if user && user.authenticate(params[:password])
      add_session(user.id)
      if user.role == "customer"
        redirect_to menus_path
      elsif user.owner?
        redirect_to users_path
      else
        redirect_to manage_orders_path
      end
    else
      flash[:error] = "Invalid login attempt."
      redirect_to new_session_path
    end
  end

  def destroy
    remove_session()
    redirect_to "/"
  end
end
