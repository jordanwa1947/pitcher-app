class MatchesController < ApplicationController

  before_action :authenticate

  def index
    new_local_session if needs_locals?
    @facade = MatchesFacade.new(current_user, session[:locals].shift)
  end

  def create
    data       = params[:restaurant_info]
    restaurant = Restaurant.create_self( data )
    # is this making duplicate restaurants?
    yelp_id    = data[:id]
    wishlist   = current_user.wishlists.create(yelp_id: yelp_id, restaurant: restaurant)
    redirect_to matches_path
  end

  def destroy
    redirect_to matches_path
  end

  def update
    session[:matches] = Hash.new(0)
    redirect_to wishlist_path
  end

  private

  def needs_locals?
    session[:locals].nil? || session[:locals].empty?
  end

  def new_local_session
    target = { target: :location, location: params[:location] }
    session[:locals] = YelpService.new(target).local_restaurants
  end


end
