class Visit < ApplicationRecord
  
  belongs_to :user
  belongs_to :restaurant

  def yelp_id
    restaurant.yelp_id
  end

end
