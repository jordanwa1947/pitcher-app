
module BusinessSearchStubs

  def stub_business_search
    stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&location=1331%2017th%20Street%20Denver%20CO%2080202&radius=1609&sort_by=distance&term=restaurant").
      to_return(body: File.read("./spec/fixtures/business_search.json"))
  end

  def stub_business_search_specific
    stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&location=1634%2018th%20St,%20Denver,%20CO%2080202&radius=1609&sort_by=distance&term=restaurant").
      to_return(body: File.read("./spec/fixtures/business_search_specific.json"))
  end

  def stub_business_search_city_state
    stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&location=Denver,%20CO&radius=1609&sort_by=distance&term=restaurant").
      to_return(body: File.read("./spec/fixtures/business_search_city_state.json"))
  end

  def stub_business_search_zip
    stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&location=80202&radius=1609&sort_by=distance&term=restaurant").
      to_return(body: File.read("./spec/fixtures/business_search_zip.json"))
  end


end
