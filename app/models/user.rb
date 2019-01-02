class User < ApplicationRecord
  has_one :main_address
  has_many :wishlists
  has_many :visits
  has_many :reviews

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
    default = main_address
    [default.address, default.city, default.state, default.zip].compact.join(' ')
  end

  def default_city
    "#{main_address.city}, #{main_address.state}"
  end

  def no_repeat_restaurants(yelp_ids)
    used_restaurants = [wish_yelp_ids, visit_yelp_ids].flatten
    yelp_ids.delete_if do |yelp_id|
      used_restaurants.include?(yelp_id)
    end
  end

  def wish_yelp_ids
    wish_yelp_ids = wishlists.map do |wishlist|
      wishlist.yelp_id
    end
  end

  def visit_yelp_ids
    visits.map do |visit|
      visit.yelp_id
    end
  end

end
