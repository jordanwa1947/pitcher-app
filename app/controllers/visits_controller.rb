class VisitsController < ApplicationController
  before_action :authenticate

  def create
    wishlist = current_user.wishlists.find_by(restaurant_id: params[:id]).delete
    Visit.create(user_id: wishlist.user_id,
                restaurant_id: wishlist.restaurant_id,
                yelp_id: wishlist.yelp_id)
    redirect_to '/visited'
  end

  def index
    @visited = current_user.visits
  end
end
