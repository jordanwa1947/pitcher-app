require 'rails_helper'

describe 'Wishlist' do

  describe "Visitor" do
    it "A visitor gets redirect to the root path" do
      visit wishlist_path
      expect(page).to have_current_path(root_path)
    end
  end

  describe "User" do

    before(:each) do
      VCR.use_cassette('geocode_lookup') do
        stub_request(:get, "https://api.yelp.com/v3/businesses/cL8rbKfItlQOoFzLIQAsdA").
          to_return(body: File.read("./spec/fixtures/business_details_1.json"))
        stub_request(:get, "https://api.yelp.com/v3/businesses/eaVcCJO5OmBhAv-kJRpWRg").
          to_return(body: File.read("./spec/fixtures/business_details_2.json"))
        stub_request(:get, "https://api.yelp.com/v3/businesses/KPQ1fifN8sVnINat4xmDXQ").
          to_return(body: File.read("./spec/fixtures/business_details_10.json"))
        user = create(:user)
        address = create(:main_address, user: user)
        facade_1 = MatchesFacade.new(user, "cL8rbKfItlQOoFzLIQAsdA")
        facade_2 = MatchesFacade.new(user, "eaVcCJO5OmBhAv-kJRpWRg")
        facade_3 = MatchesFacade.new(user, "KPQ1fifN8sVnINat4xmDXQ")
        @restaurant_1 = Restaurant.create_self(facade_1.restaurant_info)
        @restaurant_2 = Restaurant.create_self(facade_2.restaurant_info)
        @restaurant_3 = Restaurant.create_self(facade_3.restaurant_info)
        user.wishlists.create(yelp_id: facade_1.restaurant_info[:id], restaurant_id: @restaurant_1.id)
        user.wishlists.create(yelp_id: facade_2.restaurant_info[:id], restaurant_id: @restaurant_2.id)
        user.wishlists.create(yelp_id: facade_3.restaurant_info[:id], restaurant_id: @restaurant_3.id)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit wishlist_path
      end
    end

    it 'A User can visit wishlist index' do
      expect(current_path).to eq(wishlist_path)
    end

    it 'Wishlist Item cards are links to restaurant show' do
      click_on @restaurant_1.name

      expect(current_path).to eq("/restaurants/#{@restaurant_1.id}")
      expect(page).to have_content(@restaurant_1.name)
      expect(page).to_not have_content(@restaurant_2.name)
      expect(page).to_not have_content(@restaurant_3.name)
    end

    xit "Only wishlist items in my default location city are visible" do
      expect(page).to have_content(@restaurant_1.name)
      expect(page).to have_content(@restaurant_1.phone_number)
      expect(page).to have_content(@restaurant_2.name)
      expect(page).to have_content(@restaurant_2.phone_number)
      expect(page).to_not have_content(@restaurant_3.name)
      expect(page).to_not have_content(@restaurant_3.phone_number)
    end

    xit "Displays wishlist items from other cities when I click expand" do
      click_on("Aurora, CO")

      expect(page).to have_content(@restaurant_3.name)
      expect(page).to have_content(@restaurant_3.city)
    end

  end


end
