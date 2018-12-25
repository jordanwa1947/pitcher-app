class DirectionsController < ApplicationController

  def show
    @restaurant = Restaurant.find(params[:id])
    @address = current_user.main_address
  end
  
end
