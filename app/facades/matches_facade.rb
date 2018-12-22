class MatchesFacade

  attr_reader :restaurant_id

  def initialize(user, restaurant_id)
    @user = user
    @restaurant_id = restaurant_id
  end

  def images
    response = conn.get("#{restaurant_id}")
    body = JSON.parse(response.body, symbolize_names: true)
    return body[:photos]
  end

  # def restaurants
  #   response = conn.get("search?term=restaurant&location=#{user.build_address}&radius=1609&limit=10&sort_by=distance")
  #   body = JSON.parse(response.body, symbolize_names: true)
  #   return body[:businesses]
  # end

  private
  
  attr_reader :user

  def conn
    Faraday.new(:url => 'https://api.yelp.com/v3/businesses/') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
      faraday.adapter  Faraday.default_adapter
    end
  end

end
