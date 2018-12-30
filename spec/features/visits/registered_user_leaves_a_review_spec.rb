require 'rails_helper'

describe 'As a registered user' do

  describe 'when I visit the visited restaurants page' do

    let(:user) { create(:user) }
    let(:restaurant) {create(:restaurant)}
    before(:each) do
      VCR.use_cassette('geocode_lookup', record: :all) do
        # @user = create(:user)
        # address = create(:main_address, user: @user)
        address = create(:main_address, user: user)
        # @restaurant = create(:restaurant)
        # visit = create(:visit, user: @user, restaurant: @restaurant)
        # visit = create(:visit, user: user, restaurant: @restaurant)
        visit = create(:visit, user: user, restaurant: restaurant)
        # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit visited_path
      end
    end

    it 'displays a form to leave a rating and review' do
        expect(page).to have_content("Leave a Review")
    end

    describe 'when I enter a rating and review' do

      before(:each) do
        fill_in 'Review Title', with: 'First Review'
        fill_in 'Rating', with: 5
        fill_in 'Review', with: 'This is my first review.'
        click_button 'Create Review'
      end

      it 'redirects me to the restaurant show page' do
        # expect(current_path).to eq(restaurant_path(@restaurant.id))
        expect(current_path).to eq(restaurant_path(restaurant.id))
      end

      it 'displays my review on the restaurant show page' do
        expect(page).to have_content("First Review")
        expect(page).to have_content("This is my first review.")
        # expect(page).to have_content(@user.first_name)
        expect(page).to have_content(user.first_name)
      end

      it 'displays reviews from other users' do
        VCR.use_cassette('geocode_lookup', record: :all) do
          @user_2 = create(:user)
          address_2 = create(:main_address, user: @user_2)
          # visit_2 = create(:visit, user: @user_2, restaurant: @restaurant)
          visit_2 = create(:visit, user: @user_2, restaurant: restaurant)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
          visit visited_path
          fill_in 'Review Title', with: 'New Review'
          fill_in 'Rating', with: 4
          fill_in 'Review', with: 'This is a new review.'
          click_button 'Create Review'

          expect(page).to have_content("First Review")
          expect(page).to have_content("This is my first review.")
          # expect(page).to have_content(@user.first_name)
          expect(page).to have_content(user.first_name)
          expect(page).to have_content("New Review")
          expect(page).to have_content("This is a new review.")
          expect(page).to have_content(@user_2.first_name)
        end
      end

      it 'displays my rating and review for restaurants I already reviewed' do
        visit visited_path

        expect(page).to_not have_content("Leave a Review")
        expect(page).to have_content("My Review")
        expect(page).to have_content("Rating: 5")
        expect(page).to have_content("Title: First Review")
        expect(page).to have_content("This is my first review.")
      end
    end
  end
end
