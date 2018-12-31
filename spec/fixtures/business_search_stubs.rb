
module BusinessSearchStubs

  def stub_business_search
    stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&location=1331%2017th%20Street%20Denver%20CO%2080202&radius=1609&sort_by=distance&term=restaurant").
      to_return(body: File.read("./spec/fixtures/business_search.json"))
  end

end
