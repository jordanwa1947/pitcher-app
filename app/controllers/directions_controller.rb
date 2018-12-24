class DirectionsController < ApplicationController

  before_action :authenticate

  def show
    @restaurant = Restaurant.find( params[:id] )
    @facade     = DirectionsFacade.new( @restaurant.id )
  end
end
