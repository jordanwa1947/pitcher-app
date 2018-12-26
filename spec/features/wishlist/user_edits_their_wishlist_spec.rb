require 'rails_helper'

describe 'User edits their wishlist' do

  before(:each) do
    VCR.use_cassette('geocode_lookup') do
      stub_request(:get, "https://api.yelp.com/v3/businesses/cL8rbKfItlQOoFzLIQAsdA")
      .to_return(body: File.read("./spec/fixtures/business_details_1.json"))

      user = create(:user)
      address = create(:main_address, user: user)

      facade = MatchesFacade.new(user, "cL8rbKfItlQOoFzLIQAsdA")
      @restaurant = Restaurant.create_self(facade.restaurant_info)

      user.wishlists.create(yelp_id: facade.restaurant_info[:id], restaurant_id: @restaurant.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
  end
  describe 'they click on a restaurants move to visited list' do
    it 'moves the restaurant to the visited page' do

      visit wishlist_path

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

      visit wishlist_path

      click_button "Delete"

      expect(current_path).to eq("/wishlist")

      expect(page).to_not have_content(@restaurant.name)
      expect(page).to_not have_content(JSON.parse(@restaurant.address).join(' '))
      expect(page).to_not have_link("Yelp Reviews")
      expect(page).to_not have_css(".restaurant")
    end
  end
end
