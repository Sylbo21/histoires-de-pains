class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user, :is_admin?

  def logged_in?
    session[:user_id].present?
  end

  def ensure_authenticated
    redirect_to login_path unless(logged_in?)
  end

  def current_user
    User.find(session[:user_id])
  end

  def is_admin?
    logged_in? && current_user.role == 'admin'
  end

end
