class MainAddress < ApplicationRecord
  belongs_to :user
  delegate :main_address, to: :user

  validates_presence_of :state, :city
  geocoded_by :build_address
  after_validation :geocode, 
    if: lambda{ |address| address.address_changed? }

  def build_address
    [address, city, state, zip].compact.join(' ')
  end
end
