class ImagesFacade

  def initialize(user)
    @user = user
  end

  def photos
    images = []
    restaurants.each do |restaurant|
      response = conn.get("#{restaurant[:id]}")
      body = JSON.parse(response.body, symbolize_names: true)
      body[:photos].each do |photo_url|
        images << Image.new(photo_url, restaurant[:id])
      end
    end
    return images.shuffle
  end

  def restaurants
    response = conn.get("search?term=restaurant&location=#{current_user.build_address}&radius=#{current_user.radius}&limit=50&sort_by=distance")
    body = JSON.parse(response.body, symbolize_names: true)
    return body["businesses"]
  end

  def current_photo
    photos.shift
  end

  private
  
  attr_reader :user

  def conn
    Faraday.new(:url => 'https://api.yelp.com/v3/businesses/') do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
      faraday.adapter  Faraday.default_adapter
    end
  end

end
