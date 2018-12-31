require 'rails_helper'

describe 'As a registered user' do

  let(:user) { create(:user) }

  before(:each) do
    VCR.use_cassette('geocode_lookup') do
      address = create(:main_address, user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
  end

  describe 'when I visit the restaurant search path' do

    before(:each) do
      visit matches_path
    end

    it 'should display a form to search using a specified location' do
      expect(page).to have_content("Specify a Location")
      expect(page).to have_content("Search for:")
    end

    describe 'when I enter a complete address and click search' do

      before(:each) do
        stub_business_search_specific
        stub_business_4
        fill_in "Search for:", with: "1634 18th St, Denver, CO 80202"
        click_on "Find Matches"
      end

      it 'should display photos and like and dislike buttons' do
        expect(current_path).to eq("/matches")
        expect(page).to have_css(".photo")
        expect(page).to have_css("input#Like",   count: 1)
        expect(page).to have_css("input#Pass",   count: 1)
        expect(page).to have_css("input#Finish", count: 1)
      end
    end

    describe 'when I enter a city/state and click search' do

      before(:each) do
        stub_business_search_city_state
        stub_business_7
        fill_in "Search for:", with: "Denver, CO"
        click_on "Find Matches"
      end

      it 'should display photos and like and dislike buttons' do
        expect(current_path).to eq("/matches")
        expect(page).to have_css(".photo")
        expect(page).to have_css("input#Like",   count: 1)
        expect(page).to have_css("input#Pass",   count: 1)
        expect(page).to have_css("input#Finish", count: 1)
      end
    end

    describe 'when I enter a zip code and click search' do

      before(:each) do
        stub_business_search_zip
        stub_business_8
        stub_business_9
        fill_in "Search for:", with: "80202"
        click_on "Find Matches"
      end

      it 'should display photos and like and dislike buttons' do

        expect(current_path).to eq("/matches")
        expect(page).to have_css(".photo")
        expect(page).to have_css("input#Like",   count: 1)
        expect(page).to have_css("input#Pass",   count: 1)
        expect(page).to have_css("input#Finish", count: 1)
      end

    end
  end
end
