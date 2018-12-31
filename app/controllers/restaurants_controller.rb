class RestaurantsController < ApplicationController

  before_action :authenticate

  def show
    @restaurant = Restaurant.find(params[:id])
  end
end
