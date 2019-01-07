class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?

  def current_user
    if @current_user.blank? and session[:user_id].present?
      @current_user = User.find_by_id(session[:user_id])
    end
  end

  def user_signed_in?
    return true if current_user
  end

end
