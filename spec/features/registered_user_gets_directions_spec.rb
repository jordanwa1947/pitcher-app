require 'rails_helper'

describe 'As a registered user' do

  before(:each) do
    VCR.use_cassette('geocode_lookup', record: :all) do
      user = create(:user)
      address = create(:main_address, user: user)
      @restaurant = create(:restaurant)
      wishlist = create(:wishlist, user: user, restaurant: @restaurant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
  end

  describe 'when I visit the wishlist_path' do
    it 'allows me to get directions' do
      visit '/wishlist'

      find("div.default-wishlists").click
      click_on 'Get Directions'

      expect(current_path).to eq("/directions/#{@restaurant.id}")
    end
  end
end
