class RestaurantsController < ApplicationController

  before_action :authenticate

  def show
    restaurant = Restaurant.find(params[:id])
    @facade = RestaurantFacade.new(current_user, restaurant)
  end
end
