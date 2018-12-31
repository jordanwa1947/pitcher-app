class Visit < ApplicationRecord

  belongs_to :user
  belongs_to :restaurant

  validates_uniqueness_of :user, scope: [:restaurant]

  def yelp_id
    restaurant.yelp_id
  end

end
