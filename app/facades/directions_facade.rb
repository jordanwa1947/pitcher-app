class DirectionsFacade

  def initialize(restaurant)
    @longitude = restaurant.longitude
    @latitude = restaurant.latitude 
  end

  def directions

  end

  private

  def conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api/directions') do |faraday|
      faraday.params['key'] = ENV['google_maps_api_key']

      default_adapter Faraday.default_adapter
    end
  end
end
