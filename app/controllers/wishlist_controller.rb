
class WishlistController < ApplicationController

  def index
    four_oh_four if !current_user
    @facade = WishlistFacade.new(current_user)
  end


end
