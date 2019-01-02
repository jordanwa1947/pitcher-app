require 'rails_helper'

describe User, type: :model do

  describe 'Relationships' do
    it { should have_one  :main_address }
    it { should have_many :wishlists }
    it { should have_many :visits }
    it { should have_many :reviews }
  end

  describe 'Instance Methods' do

    let(:user) { User.create(email: 'jawesome@gmail.com',
                       first_name: 'Jordan',
                       last_name: 'Awesome',
                       uid: '12345')
               }

    before(:each) do
      VCR.use_cassette('geocode_lookup', record: :all) do
        @prime_address = MainAddress.create(address: '17th St LL100',
                                          state: 'CO',
                                          city: 'Denver',
                                          zip: '80202',
                                          user_id: user.id)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      end
    end

    it '.build address' do
      expect(user.build_address).to eq('17th St LL100 Denver CO 80202')
    end

    it '.default_city' do
      expect(user.default_city).to eq('Denver, CO')
    end

    it '.no_repeat_restaurants' do
      yelp_ids = ["cL8rbKfItlQOoFzLIQAsdA", "eaVcCJO5OmBhAv-kJRpWRg",
                  "us9NRKZDQZH0iKgEmdhbJQ", "4a-dMSzzPiIyZqj0pTlCGQ",
                  "kRmYd-YMlTswHBnK4LBf2A", "RtbHHTs4vdKUJdVQAGrwfw",
                  "rY6nzLptDIfZ2XA205u-rA", "SeYUNIIf5D-Nz715rAJjig",
                  "OfXj0dgT4fSXP9QRVBiW7g", "BkSzW46iEOPsfGwelzzp9w",
                  "iJ6FqDjSW96Uz42bSk9t8g", "UM9gzn5tmWwGeNyVgyNaBg",
                  "YxeTWblmRB3m7egJzgAJCg", "khGook-ivF2pwlv32N4wCQ",
                  "wL04ets5vd2CGxbzj3ii5w", "1RUhg_pr4ypX7BquEjirRQ",
                  "RcwpMQlFG9Di-g9OMMhyGg", "IObqOwWu1IdqdI7A-BzD7A",
                  "hks-LDU4R-mJJvr9bBfguQ", "UTV40d3C0P7vfUUqmPl3vA"]

      restaurant = create(:restaurant)
      restaurant_2 = create(:restaurant, yelp_id: "YxeTWblmRB3m7egJzgAJCg")

      Visit.create(user_id: user.id, restaurant_id: restaurant.id)
      VCR.use_cassette('geocode_lookup') do
        Wishlist.create!(user_id: user.id, restaurant_id: restaurant_2.id, searched_address: '17th St LL100 Denver CO 80202')
      end
      never_chosen = user.no_repeat_restaurants(yelp_ids)

      expect(never_chosen.count).to eq 18
      expect(never_chosen.include?("YxeTWblmRB3m7egJzgAJCg")).to eq false
      expect(never_chosen.include?("eaVcCJO5OmBhAv-kJRpWRg")).to eq false
    end

  end
end
