class MatchesController < ApplicationController

  def index
    if  session[:locals].nil? || session[:locals].empty?
      session[:locals] = current_user.local_restaurants(params[:location])
    end
    @facade = MatchesFacade.new(current_user, session[:locals].shift.first)
  end

  def create
    current_user.wishlists.create(restaurant_id: params[:restaurant_id])
    redirect_to matches_path
  end

  def destroy
    redirect_to matches_path
  end

  def update
    session[:matches] = Hash.new
    redirect_to wishlist_path
  end

end