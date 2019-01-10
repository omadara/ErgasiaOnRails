class SessionsController < ApplicationController
  skip_before_action :require_login!

  def login
    user = User.find_by_username(params[:username])
    if user.present? and user.password == params[:password]
      session[:user_id] = user.id
      flash[:info] = "Welcome back, #{user.full_name}!"
      redirect_to root_path
    else
      flash[:danger] = "Invalid username or password"
      redirect_to login_page_path
    end
  end

  def destroy
    flash[:info] = "See you again, #{current_user.full_name}!"
    session[:user_id] = nil
    redirect_to root_path
  end

  def login_from_google
    user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    session[:user_id] = user.id
    flash[:info] = "Welcome back, #{user.full_name}!"
    redirect_to root_path
  end

end
