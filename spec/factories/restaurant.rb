FactoryBot.define do

  factory :restaurant do
    longitude    {-104.997280}
    latitude     {39.750460}
    yelp_link    {"https://www.yelp.com/biz/the-delectable-egg-denver-denver?adjust_creative=87PBg7bGZgP_uA1xaaYqzw&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_lookup&utm_source=87PBg7bGZgP_uA1xaaYqzw"}
    yelp_id      {"eaVcCJO5OmBhAv-kJRpWRg"}
    phone_number {"(303) 572-8146"}
    address      {"[\"1642 Market St\", \"Denver, CO 80202\"]"}
    name         {"The Delectable Egg-Denver"}
    city         {"Denver"}
    image        {"https://s3-media1.fl.yelpcdn.com/bphoto/ftIQr9MZOZoyPvIjeoapUA/o.jpg"}
  end
  
end
