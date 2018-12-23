class MatchesController < ApplicationController

  before_action :authenticate

  def index
    if session[:locals].nil? || session[:locals].empty?
      session[:locals] = current_user.local_restaurants( params[:location] )
    end
    @facade = MatchesFacade.new(current_user, session[:locals].shift.first)
  end

  def create
    restaurant = Restaurant.create_self(params[:restaurant_info])
    wishlist   = current_user.wishlists.create(yelp_id: params[:restaurant_info][:id], restaurant_id: restaurant.id)
    redirect_to matches_path
  end

  def destroy
    redirect_to matches_path
  end

  def update
    session[:matches] = Hash.new(0)
    redirect_to wishlist_path
  end

end
