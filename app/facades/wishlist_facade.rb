class WishlistFacade

  def initialize(user)
    @user = user
  end

  def restaurants
    Restaurant.joins(:wishlists)
              .where("wishlists.user_id = ?", user.id)
  end

  def default_restaurants
    Restaurant.joins(:wishlists)
              .where("wishlists.user_id = ?", user.id)
              .where("restaurants.city = ?", user.default_city)
  end

  def other_restaurants
    Restaurant.joins(:wishlists)
              .where("wishlists.user_id = ?", user.id)
              .where("restaurants.city != ?", user.default_city)
  end

  private

  attr_reader :user

end
