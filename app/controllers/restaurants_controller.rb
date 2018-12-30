class RestaurantsController < ApplicationController

  def show
    restaurant = Restaurant.find(params[:id])
    @facade = RestaurantFacade.new(current_user, restaurant)
  end
end