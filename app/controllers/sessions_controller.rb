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
      redirect_to menus_path
    else
      redirect_to new_session_path
    end
  end

  def destroy
    remove_session()
    redirect_to "/"
  end
end
