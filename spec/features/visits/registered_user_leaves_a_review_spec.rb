require 'rails_helper'

describe 'As a registered user' do

  describe 'when I visit the visited restaurants page' do

    let(:user)       { create(:user) }
    let(:restaurant) { create(:restaurant) }

    before(:each) do
      VCR.use_cassette('geocode_lookup', record: :all) do
        address = create(:main_address, user: user)
        visit   = create(:visit, user: user, restaurant: restaurant)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit visited_path
      end
    end

    it 'displays a form to leave a rating and review' do
      expect(page).to have_button("Leave A Review")
    end

    describe 'when I enter a rating and review' do

      before(:each) do
        click_on 'Leave A Review'
        fill_in 'review[title]',        with: 'First Review'
        fill_in 'review[rating]',       with: 5
        fill_in 'review[review]',       with: 'This is my first review.'
        click_button 'Create Review'
      end

      it 'redirects me to the restaurant show page' do
        expect(current_path).to eq(restaurant_path(restaurant.id))
      end

      it 'displays my review on the restaurant show page' do
        expect(page).to have_content("First Review")
        expect(page).to have_content("This is my first review.")
        expect(page).to have_content(user.first_name)
      end

      it 'displays reviews from other users' do
        VCR.use_cassette('geocode_lookup', record: :all) do
          @user_2   = create(:user)
          address_2 = create(:main_address, user: @user_2)
          visit_2   = create(:visit, user: @user_2, restaurant: restaurant)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
          visit visited_path
          fill_in 'review[title]', with: 'New Review'
          fill_in 'review[rating]',       with: 4
          fill_in 'review[review]',       with: 'This is a new review.'
          click_button 'Create Review'

          expect(page).to have_content("First Review")
          expect(page).to have_content("This is my first review.")
          expect(page).to have_content(user.first_name)
          expect(page).to have_content("New Review")
          expect(page).to have_content("This is a new review.")
          expect(page).to have_content(@user_2.first_name)
        end
      end

      it 'displays my rating and review for restaurants I already reviewed' do
        visit visited_path

        expect(page).to_not have_content("Leave A Review")
        expect(page).to     have_content("My Review")
        expect(page).to     have_content("Rating: 5")
        expect(page).to     have_content("Title: First Review")
        expect(page).to     have_content("This is my first review.")
      end
    end
  end
end
