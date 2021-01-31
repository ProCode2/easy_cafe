class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in

  def ensure_user_logged_in
    unless current_user
      redirect_to "/"
    end
  end

  def ensure_user_is_owner
    unless current_user.owner?
      redirect_to "/"
    end
  end

  def ensure_user_is_clerk
    unless current_user.owner? or current_user.clerk?
      redirect_to "/"
    end
  end

  def current_user
    return @current_user if @current_user
    @current_user_id = session[:current_user_id]
    if @current_user_id
      @current_user = User.find(@current_user_id)
    else
      nil
    end
  end

  # start an user session
  def add_session(user_id)
    session[:current_user_id] = user_id
  end

  # stop an user session
  def remove_session()
    session[:current_user_id] = nil
    @current_user = nil
  end
end
