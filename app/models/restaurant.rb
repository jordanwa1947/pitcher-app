class Restaurant < ApplicationRecord
  has_many :wishlists
  has_many :reviews
  has_many :photos

  validates_presence_of :longitude,
                        :latitude,
                        :yelp_link,
                        :address,
                        :name,
                        :city
  validates :yelp_id, presence: true, uniqueness: true

  def self.create_self(data)
    create(
      longitude:    data[:coordinates][:longitude],
      latitude:     data[:coordinates][:latitude],
      yelp_id:      data[:id],
      yelp_link:    data[:url],
      yelp_rating:  data[:rating],
      yelp_reviews: data[:review_count],
      phone_number: data[:display_phone],
      address:      data[:location][:display_address],
      name:         data[:name],
      image:        data[:image_url],
      city:         "#{data[:location][:city]}, #{data[:location][:state]}"
    )
  end
end
