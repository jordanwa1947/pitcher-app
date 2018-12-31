class MatchesController < ApplicationController

  before_action :authenticate

  def index
    return unless params[:location] #render page without a facade if no location
    session[:locals] = Hash.new unless session[:location] == params[:location] #reset session[:locals] if location has changed
    session[:location] = params[:location] #save location in sessions
    new_local_session if needs_locals?
    @facade = MatchesFacade.new(current_user, session[:locals].shift)
    redirect_to matches_path(location: session[:location]) if @facade.images.empty? #skip restaurants without photos
  end

  def create
    data       = params[:restaurant_info]
    id         = data[:id]
    restaurant = Restaurant.find_by(yelp_id: id) || Restaurant.create_self( data )
    wishlist   = current_user.wishlists.create(yelp_id: id, restaurant: restaurant)
    redirect_to matches_path(location: session[:location])
  end

  def destroy
    redirect_to matches_path(location: session[:location])
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
