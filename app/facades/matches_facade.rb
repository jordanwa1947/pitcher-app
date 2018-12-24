class MatchesFacade

  attr_reader :yelp_id

  def initialize(user, yelp_id)
    @user    = user
    @yelp_id = yelp_id
  end

  def images
    restaurant_info[:photos]
  end

  def restaurant_info
    target = { target: :business, business: @yelp_id }
    YelpService.new( target ).get_target
  end

end
