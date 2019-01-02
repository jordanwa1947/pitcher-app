
class Wishlist < ApplicationRecord
  validates_presence_of :searched_address
  validates_uniqueness_of :user, scope: [:restaurant]

  geocoded_by :address
  after_validation :geocode

  belongs_to :user
  belongs_to :restaurant


  def yelp_id
    restaurant.yelp_id
  end

  def address
    searched_address
  end
end
