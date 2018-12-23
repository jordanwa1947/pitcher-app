

class YelpService

  def initialize( filter )
    @filter   = filter
    @base_url = 'https://api.yelp.com/v3/'
    @target   = filter[:target]
  end


  def get_target
    get_json( pick_endpoint )
  end

  # This is no longer a hash because we're only using it
  # for the id, and destructively removing it to create
  # each facade & view
  def local_restaurants
    data = get_target[:businesses]
    data.map { |local| local[:id] }
  end


  private

  def pick_endpoint
    target_options[@target]
  end

  def target_options
    {
      location: "businesses/search?#{restrictions_as_params}",
      business: "businesses/#{business}"
    }
  end

  def business
    @filter[:business]
  end

  def restrictions
    @term    = "restaurant"
    @sort_by = 'distance'
    @limit   = 20
    @radius  = @filter[:radius] || 1609 #40000 # meters (~25 miles) - max before yelp breaks
  end

  def restrictions_as_params
    restrictions
    "term=#{@term}&"       +
    "sort_by=#{@sort_by}&" +
    "limit=#{@limit}&"     +
    "radius=#{@radius}&"   +
    "location=#{location}"
  end

  def location
    @filter[:location]
  end

  def get_json(url)
    response = public_connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def public_connection
    Faraday.new(url: @base_url) do |f|
      f.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
      f.adapter Faraday.default_adapter
    end
  end



end
