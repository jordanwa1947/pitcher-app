class DirectionsController < ApplicationController

  def show
    @restaurant = Restaurant.find(params[:id]).to_i 
    @facade = DirectionsFacade.new(params[:id].to_i)
  end
end
