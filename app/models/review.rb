class Review < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :rating
  validates_presence_of :review
end