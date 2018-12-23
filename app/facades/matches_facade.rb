class MatchesFacade

  attr_reader :yelp_id

  def initialize(user, yelp_id)
    @user = user
    @yelp_id = yelp_id
  end

  def images
    body = get_json
    return body[:photos]
  end

  def restaurant_info
    get_json
  end

  # def restaurants
  #   response = conn.get("search?term=restaurant&location=#{user.build_address}&radius=1609&limit=10&sort_by=distance")
  #   body = JSON.parse(response.body, symbolize_names: true)
  #   return body[:businesses]
  # end

  private

  attr_reader :user

  def get_json
    @json ||= conn.get("#{yelp_id}")
    JSON.parse(@json.body, symbolize_names: true)
  end

  def conn
    Faraday.new(:url => 'https://api.yelp.com/v3/businesses/') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
      faraday.adapter  Faraday.default_adapter
    end
  end

end
