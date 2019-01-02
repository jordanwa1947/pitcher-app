require 'rails_helper'

describe 'Wishlist' do

  describe "Visitor" do
    it "A visitor gets redirect to the root path" do
      visit wishlist_path
      expect(page).to have_current_path(root_path)
    end
  end

  describe "User" do

    let(:user)         { create(:user) }
    let(:facade_1)     { MatchesFacade.new(user, "cL8rbKfItlQOoFzLIQAsdA") }
    let(:facade_2)     { MatchesFacade.new(user, "eaVcCJO5OmBhAv-kJRpWRg") }
    let(:facade_3)     { MatchesFacade.new(user, "KPQ1fifN8sVnINat4xmDXQ") }
    let(:restaurant_1) { Restaurant.create_self(facade_1.restaurant_info) }
    let(:restaurant_2) { Restaurant.create_self(facade_2.restaurant_info) }
    let(:restaurant_3) { Restaurant.create_self(facade_3.restaurant_info) }
    # let(:wishlist_1)   { user.wishlists.create(restaurant: restaurant_1) }
    # let(:wishlist_2)   { user.wishlists.create(restaurant: restaurant_2) }
    # let(:wishlist_3)   { user.wishlists.create(restaurant: restaurant_3) }

    before(:each) do
      VCR.use_cassette('geocode_lookup') do
        stub_business_1
        stub_business_2
        stub_business_10
        address = create(:main_address, user: user)
        user.wishlists.create(restaurant: restaurant_1)
        user.wishlists.create(restaurant: restaurant_2)
        user.wishlists.create(restaurant: restaurant_3)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit wishlist_path
      end
    end

    it 'A User can visit wishlist index' do
      expect(current_path).to eq(wishlist_path)
    end

    it 'Wishlist Item cards are links to restaurant show' do
      click_on restaurant_1.name

      expect(current_path).to eq("/restaurants/#{restaurant_1.id}")
      expect(page).to     have_content(restaurant_1.name)
      expect(page).to_not have_content(restaurant_2.name)
      expect(page).to_not have_content(restaurant_3.name)
    end

    it "Only wishlist items in my default location city are visible" do

      within(".default-wishlists") do
        expect(page).to     have_content(restaurant_1.name)
        expect(page).to     have_content(restaurant_1.phone_number)
        expect(page).to     have_content(restaurant_2.name)
        expect(page).to     have_content(restaurant_2.phone_number)
        expect(page).to_not have_content(restaurant_3.name)
        expect(page).to_not have_content(restaurant_3.phone_number)
      end
    end

    it "Displays wishlist items from other cities when I click expand" do

      within("#other-wishlists") do
        expect(page).to have_content(restaurant_3.name)
        expect(page).to have_content(restaurant_3.city)
      end

    end
  end
end
