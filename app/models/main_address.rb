class MainAddress < ApplicationRecord
  belongs_to :user
  delegate :main_address, to: :user

  validates_presence_of :state, :city
end
