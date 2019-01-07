class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id].present?
  end

  def user_signed_in?
    current_user.present?
  end

end
