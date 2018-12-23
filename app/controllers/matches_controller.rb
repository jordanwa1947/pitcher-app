class MatchesController < ApplicationController

  def index
    must_be_logged_in
    if session[:locals].nil? || session[:locals].empty?
      session[:locals] = current_user.local_restaurants(params[:location])
    end
    @facade = MatchesFacade.new(current_user, session[:locals].shift.first)
  end

  def create
    must_be_logged_in
    restaurant = Restaurant.create_self(params[:restaurant_info])
    wishlist = current_user.wishlists.create(yelp_id: params[:restaurant_info][:id], restaurant_id: restaurant.id)
    redirect_to matches_path
  end

  def destroy
    must_be_logged_in
    redirect_to matches_path
  end

  def update
    must_be_logged_in
    session[:matches] = Hash.new
    redirect_to wishlist_path
  end

end
