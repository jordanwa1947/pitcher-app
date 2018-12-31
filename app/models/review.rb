class Review < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  validates_uniqueness_of :user, scope: [:restaurant]

  validates_presence_of :title
  validates_presence_of :rating
  validates_presence_of :review

  def author
    user.first_name
  end

end
