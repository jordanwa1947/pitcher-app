class DirectionsController < ApplicationController

  def show
    must_be_logged_in
    @restaurant = Restaurant.find( params[:id] )
    @facade     = DirectionsFacade.new( @restaurant.id )
  end
end
