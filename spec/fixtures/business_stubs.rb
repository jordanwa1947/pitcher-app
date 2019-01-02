
module BusinessStubs

  def stub_business_1
    stub_request(:get, "https://api.yelp.com/v3/businesses/cL8rbKfItlQOoFzLIQAsdA").
      to_return(body: File.read("./spec/fixtures/business_details_1.json"))
  end

  def stub_business_2
    stub_request(:get, "https://api.yelp.com/v3/businesses/eaVcCJO5OmBhAv-kJRpWRg").
      to_return(body: File.read("./spec/fixtures/business_details_2.json"))
  end

  def stub_business_3
    stub_request(:get, "https://api.yelp.com/v3/businesses/us9NRKZDQZH0iKgEmdhbJQ").
      to_return(body: File.read("./spec/fixtures/business_details_3.json"))
  end

  def stub_business_4
    stub_request(:get, "https://api.yelp.com/v3/businesses/AufxrKk-COzfAMr9KMVWRA").
      to_return(body: File.read("./spec/fixtures/business_details_4.json"))
  end

  def stub_business_7
    stub_request(:get, "https://api.yelp.com/v3/businesses/mKRMTGAOQKPIdhi8LKB4Tg").
      to_return(body: File.read("./spec/fixtures/business_details_7.json"))
  end

  def stub_business_8
    stub_request(:get, "https://api.yelp.com/v3/businesses/idKs48V1lf8LQwvcFJjzGg").
      to_return(body: File.read("./spec/fixtures/business_details_8.json"))
  end

  def stub_business_9
    stub_request(:get, "https://api.yelp.com/v3/businesses/9EBwv92qSn1aFTZ-oK1wag").
      to_return(body: File.read("./spec/fixtures/business_details_9.json"))
  end

  def stub_business_10
    stub_request(:get, "https://api.yelp.com/v3/businesses/KPQ1fifN8sVnINat4xmDXQ").
      to_return(body: File.read("./spec/fixtures/business_details_10.json"))
  end

end
