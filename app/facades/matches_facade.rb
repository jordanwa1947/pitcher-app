class MatchesFacade

  attr_reader :yelp_id, :location 

  def initialize(user, yelp_id, location)
    @user    = user
    @yelp_id = yelp_id
    @location = location
  end

  def images
    restaurant_info[:photos]
  end

  def restaurant_info
    target = { target: :business, business: @yelp_id }
    YelpService.new( target ).get_target
  end

end
