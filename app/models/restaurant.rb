class Restaurant < ApplicationRecord
  has_many :wishlists
  has_many :reviews

  def self.create_self(data)
    create(
      longitude:    data[:coordinates][:longitude],
      latitude:     data[:coordinates][:latitude],
      yelp_link:    data[:url],
      yelp_id:      data[:id],
      phone_number: data[:display_phone],
      address:      data[:location][:display_address],
      name:         data[:name],
      image:        data[:image_url],
      city:         "#{data[:location][:city]}, #{data[:location][:state]}"
    )
  end
end
