
class WishlistController < ApplicationController

  def index
    four_oh_four if !current_user
    @restaurants = current_user.wishlists.map do |wishlist|
      wishlist.restaurant
    end
  end


end
