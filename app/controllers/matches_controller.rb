class MatchesController < ApplicationController

  def index
    return unless params[:location] #render page without a facade if no location
    session[:locals] = Hash.new unless session[:location] == params[:location] #reset session[:locals] if location has changed
    session[:location] = params[:location] #save location in sessions
    if session[:locals].nil? || session[:locals].empty? #if session[:locals] doesn't exist or is empty
      session[:locals] = current_user.local_restaurants(params[:location]) #save restaurants in session[:locals]
    end
    @facade = MatchesFacade.new(current_user, session[:locals].shift.first)
    redirect_to matches_path(location: session[:location]) if @facade.images.empty? #skip restaurants without photos
  end

  def create
    restaurant = Restaurant.create_self(params[:restaurant_info])
    wishlist = current_user.wishlists.create(yelp_id: params[:restaurant_info][:id], 
                                             restaurant_id: restaurant.id)
    redirect_to matches_path(location: session[:location])
  end

  def destroy
    redirect_to matches_path(location: session[:location])
  end

  def update
    session[:matches] = Hash.new
    redirect_to wishlist_path
  end

end
