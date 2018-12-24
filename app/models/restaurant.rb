class Restaurant < ApplicationRecord
  has_many :wishlists

  def self.create_self(restaurant_info)
    create(
      longitude: restaurant_info[:coordinates][:longitude], 
      latitude: restaurant_info[:coordinates][:latitude],
      yelp_link: restaurant_info[:url],
      phone_number: restaurant_info[:display_phone],
      address: restaurant_info[:location][:display_address],
      name: restaurant_info[:name],
      image: restaurant_info[:image_url],
      city: "#{restaurant_info[:location][:city]}, #{restaurant_info[:location][:state]}"
    )
  end
end
