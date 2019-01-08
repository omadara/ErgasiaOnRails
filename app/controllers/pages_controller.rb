class PagesController < ApplicationController
  skip_before_action :require_login!

  def register
    @user = User.new
  end

  def register_post
    @user = User.new(register_user_params)
    if params[:user][:password] != params[:user][:password_confirmation]
      @user.errors.messages[:password] = ["confirmation doesn't match"]
      render 'register' and return
    end
    @user.password_digest = BCrypt::Password.create(params[:user][:password])
    if @user.save
      flash[:success] = "Account registered, you can now login"
      redirect_to login_page_path
    else
      render 'register'
    end
  end

  private
  def register_user_params
    params.require(:user).permit(:username, :first_name, :last_name)
  end

end
