# TO DO - When we create restaurants
# add a column to the table for restaurant:references

class Wishlist < ApplicationRecord
  # TO DO - I don't think you can validate default value ?

  belongs_to :user
  belongs_to :restaurant
  validates_uniqueness_of :restaurant_id




end
