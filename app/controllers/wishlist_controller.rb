
class WishlistController < ApplicationController

  def index
    must_be_logged_in
    @restaurants = current_user.wishlists.map do |wishlist|
      wishlist.restaurant
    end
  end


end
