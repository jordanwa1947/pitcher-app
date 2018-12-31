
module WishlistStubs

  def stub_business_1
    stub_request(:get, "https://api.yelp.com/v3/businesses/cL8rbKfItlQOoFzLIQAsdA").
      to_return(body: File.read("./spec/fixtures/business_details_1.json"))
  end

  def stub_business_2
    stub_request(:get, "https://api.yelp.com/v3/businesses/eaVcCJO5OmBhAv-kJRpWRg").
      to_return(body: File.read("./spec/fixtures/business_details_2.json"))
  end

  def stub_business_3
    stub_request(:get, "https://api.yelp.com/v3/businesses/KPQ1fifN8sVnINat4xmDXQ").
      to_return(body: File.read("./spec/fixtures/business_details_10.json"))
  end


end
