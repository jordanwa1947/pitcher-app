
class WishlistController < ApplicationController

  before_action :authenticate

  def index
    @restaurants = current_user.wishlists.map do |wishlist|
      wishlist.restaurant
    end
  end


end
