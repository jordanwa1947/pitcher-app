class VisitsController < ApplicationController

  before_action :authenticate

  def create
    wishlist = current_user.wishlists.find_by(restaurant_id: params[:id]).delete
    Visit.create(user: wishlist.user, restaurant: wishlist.restaurant)
    redirect_to '/visited'
  end

  def index
    @visited = current_user.visits
    @review  = Review.new
  end
end
