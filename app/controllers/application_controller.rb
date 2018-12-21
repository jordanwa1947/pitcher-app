class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :main_address
  before_action :images_facade

  def authenticate
  	redirect_to '/' unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  def images_facade
    @images_facade ||= ImagesFacade.new(current_user) if current_user 
  end
end
