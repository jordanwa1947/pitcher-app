class User < ApplicationRecord
  has_one :main_address

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
    address_attributes = main_address.attributes.find_all do |attribute, value|
      value && !(attribute =~ /id/)
    end
    only_values = address_attributes.map do |value|
      value[1]
    end.join(' ')
  end
end
