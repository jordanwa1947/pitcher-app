require 'rails_helper'

  describe Visit, type: :model do

    let(:user)       { create(:user) }
    let(:restaurant) { create(:restaurant) }
    let(:visit)      { create(:visit, user: user, restaurant: restaurant) }


    describe "Relationships" do
      it { should belong_to :user }
      it { should belong_to :restaurant }
    end

    describe "Validations" do
      it 'validate only one visit per user-restaurant pair' do
        validate_uniqueness_of(user).scoped_to(:restaurant)
        validate_uniqueness_of(:user).scoped_to(restaurant)
      end
    end

    describe "Methods" do

      it 'can access yelp_id' do
        id = visit.yelp_id
        expect(id).to eq(restaurant.yelp_id)
      end

    end

  end
