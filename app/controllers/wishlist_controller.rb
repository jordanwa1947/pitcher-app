
class WishlistController < ApplicationController

  before_action :authenticate

  def index
    @facade = WishlistFacade.new(current_user)
  end

  def destroy
    wishlist = current_user.wishlists.find_by(restaurant_id: params[:id])
    wishlist.delete
    redirect_to '/wishlist'
  end

end
