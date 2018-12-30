require 'rails_helper'

describe 'As a registered user' do

  before(:each) do
    VCR.use_cassette('geocode_lookup', record: :all) do
      @user = create(:user)
      address = create(:main_address, user: @user)
      @restaurant = create(:restaurant)
      wishlist = create(:wishlist, user: @user, restaurant: @restaurant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)      
    end
  end

  describe 'when I click on a restaurant name anywhere on the site' do

    before(:each) do
      visit wishlist_path
      click_on @restaurant.name
    end

    it 'should redirect to the restaurant show page' do
      expect(current_path).to eq(restaurant_path(@restaurant.id))
      expect(page).to have_content(@restaurant.name)
      expect(page).to have_content(@restaurant.address)
      expect(page).to have_content(@restaurant.phone_number)
      expect(page).to have_content("Yelp Rating:")
      expect(page).to have_content("Pitcher User Rating: N/A")
      expect(page).to have_content("This restaurant doesn't have any reviews yet.")
    end

    describe 'if the restaurant is in my wishlist' do

      it 'should display a wishlist banner' do
        expect(page).to have_css("div.user-status-banner", value: "Recommended")
      end

    end

    describe 'if the restaurant is in my visited list' do

      before(:each) do
        visit wishlist_path
        click_button "Move to Visited"
      end

      it 'should display a visited banner' do
        expect(page).to have_css("div.user-status-banner", valude: "Visited")
      end
    end

    describe 'if the restaurant has reviews' do

      before(:each) do
        visit wishlist_path
        fill_in 'Review Title', with: 'First Review'
        fill_in 'Rating', with: 5
        fill_in 'Review', with: 'This is my first review.'
        click_button 'Create Review'
      end

      it 'should display the average user rating for the restaurant' do
        expect(page).to have_content("Pitcher User Rating: 5")
      end

      it 'should display the review' do
        expect(page).to_not have_content("This restaurant doesn't have any reviews yet.")
        expect(page).to have_content('First Review')
        expect(page).to have_content('This is my first review.')
        expect(page).to have_content(@user.first_name)
      end
    end
  end
end