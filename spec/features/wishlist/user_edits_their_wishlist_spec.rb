require 'rails_helper'

describe 'User edits their wishlist' do

  let(:user)   { create(:user) }
  let(:facade) { MatchesFacade.new(user, "cL8rbKfItlQOoFzLIQAsdA") }

  before(:each) do
    VCR.use_cassette('geocode_lookup') do
      stub_business_1
      address = create(:main_address, user: user)
      @restaurant = Restaurant.create_self(facade.restaurant_info)
      user.wishlists.create(restaurant: @restaurant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit wishlist_path
    end
  end

  describe 'they click on a restaurants move to visited list' do

    it 'moves the restaurant to the visited page' do
      click_button "Move to Visited"

      expect(current_path).to eq("/visited")
      expect(page).to have_content(@restaurant.name)
      expect(page).to have_content(JSON.parse(@restaurant.address).join(' '))
      expect(page).to have_link("Yelp Reviews")
      expect(page).to have_css(".restaurant")

      click_link "Wishlist"

      expect(page).to_not have_content(@restaurant.name)
      expect(page).to_not have_content(JSON.parse(@restaurant.address).join(' '))
      expect(page).to_not have_link("Yelp Reviews")
      expect(page).to_not have_css(".restaurant")
    end
  end

  describe 'to user clicks on a wishlist items delete button' do

    it 'deletes a wishlist item from their wishlist' do
      click_button "Delete"

      expect(current_path).to eq("/wishlist")

      expect(page).to_not have_content(@restaurant.name)
      expect(page).to_not have_content(JSON.parse(@restaurant.address).join(' '))
      expect(page).to_not have_link("Yelp Reviews")
      expect(page).to_not have_css(".restaurant")
    end
  end
end
