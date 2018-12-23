class User < ApplicationRecord
  has_one :main_address
  has_many :wishlists

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

end
