class DirectionsController < ApplicationController

  before_action :authenticate

  def show
    @restaurant = Restaurant.find(params[:id])
    @address = current_user.main_address
  end

end
