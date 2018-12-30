class RestaurantFacade

  attr_reader :restaurant

  def initialize(user, restaurant)
    @user = user
    @restaurant = restaurant
  end

  def recommended?
    user.wishlists.exists?(restaurant_id: restaurant.id)
  end

  def visited?
    user.visits.exists?(restaurant_id: restaurant.id)
  end

  def user_rating
    restaurant.reviews.average(:rating  )
  end

private

  attr_reader :user

end