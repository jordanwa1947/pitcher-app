class User < ApplicationRecord
  has_one :main_address
  has_many :wishlists

  def self.find_or_create_user(auth)
    where(uid: auth[:uid]).first_or_initialize.tap do |user|
      user.first_name = auth[:info][:first_name]
      user.last_name = auth[:info][:last_name]
      user.email = auth[:info][:email]
      user.uid = auth[:uid]
      user.save!
    end
  end

  def build_address
    address_attributes = main_address.attributes.find_all do |attribute, value|
      value && !(attribute =~ /id/)
    end
    only_values = address_attributes.map do |value|
      value[1]
    end.join(' ')
  end

  def local_restaurants(location)
    response = conn.get("search?term=restaurant&location=#{location}&radius=1609&limit=20&sort_by=distance")
    body = JSON.parse(response.body, symbolize_names: true)
    restaurants = Hash.new
    body[:businesses].map do |business|
      restaurants[business[:id]] = 0
    end
    return restaurants
  end

  def conn
    Faraday.new(:url => "https://api.yelp.com/v3/businesses/") do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
      faraday.adapter  Faraday.default_adapter
    end
  end
end
