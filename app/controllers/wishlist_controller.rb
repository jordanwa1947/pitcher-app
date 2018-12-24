
class WishlistController < ApplicationController

  before_action :authenticate

  def index
    @facade = WishlistFacade.new(current_user)
  end


end
