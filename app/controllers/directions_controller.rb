class DirectionsController < ApplicationController

  before_action :authenticate

  def show
    @restaurant = Restaurant.find(params[:id])
    @address = current_user.wishlists.find_by(restaurant_id: params[:id]).searched_address
  end

end
