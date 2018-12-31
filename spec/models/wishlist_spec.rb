require 'rails_helper'

RSpec.describe Wishlist, type: :model do

  let(:user)       { create(:user) }
  let(:restaurant) { create(:restaurant) }
  let(:wishlist)   { create(:wishlist, user: user, restaurant: restaurant) }

  describe "Relationships" do
    it { should belong_to :user }
    it { should belong_to :restaurant }
  end

  describe "Validations" do
    it 'validate only one wishlist per user-restaurant pair' do
      validate_uniqueness_of(user).scoped_to(:restaurant)
      validate_uniqueness_of(:user).scoped_to(restaurant)
    end
  end

  describe "Methods" do

    it 'can access yelp_id' do
      id = wishlist.yelp_id
      expect(id).to eq(restaurant.yelp_id)
    end

  end

end
