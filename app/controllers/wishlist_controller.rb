
class WishlistController < ApplicationController

  def index
    four_oh_four if !current_user
    @wishlist = Wishlist.all
  end


end
