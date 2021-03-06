class SessionsController < ApplicationController

  def create
    @user = User.find_or_create_user(request.env["omniauth.auth"])
    session[:user_id] = @user.id
    session[:matches] = Hash.new(0)
    flash[:success]   = "You've Successfully Logged In!"
    redirect_to dashboard_path
  end

  def destroy
    authenticate
    session[:user_id] = nil
    redirect_to root_path
  end
end
