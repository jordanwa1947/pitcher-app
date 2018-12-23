require 'rails_helper'

describe 'As a registered user' do

  before(:each) do
    VCR.use_cassette('geocode_lookup') do
      user = create(:user)
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
        stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&location=1634%2018th%20St,%20Denver,%20CO%2080202&radius=1609&sort_by=distance&term=restaurant").
          to_return(body: File.read("./spec/fixtures/business_search_specific.json"))
        stub_request(:get, "https://api.yelp.com/v3/businesses/AufxrKk-COzfAMr9KMVWRA").
          to_return(body: File.read("./spec/fixtures/business_details_4.json"))
        # stub_request(:get, "https://api.yelp.com/v3/businesses/IFVAm31yNaKw5_Sa1TuP4g").
        #   to_return(body: File.read("./spec/fixtures/business_details_5.json"))
        # stub_request(:get, "https://api.yelp.com/v3/businesses/us9NRKZDQZH0iKgEmdhbJQ").
        #   to_return(body: File.read("./spec/fixtures/business_details_6.json"))
        fill_in "Search for:", with: "1634 18th St, Denver, CO 80202"
        click_on "Find Matches"
      end

      it 'should display photos and like and dislike buttons' do

        expect(current_path).to eq("/matches")
        expect(page).to have_css(".photo")
        expect(page).to have_css("input.like", count: 1)
        expect(page).to have_css("input.dislike", count: 1)
        expect(page).to have_css("input.finish", count: 1)
      end
    end

    describe 'when I enter a city/state and click search' do

      before(:each) do
        stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&location=Denver,%20CO&radius=1609&sort_by=distance&term=restaurant").
          to_return(body: File.read("./spec/fixtures/business_search_city_state.json"))
        stub_request(:get, "https://api.yelp.com/v3/businesses/mKRMTGAOQKPIdhi8LKB4Tg").
          to_return(body: File.read("./spec/fixtures/business_details_7.json"))
        # stub_request(:get, "https://api.yelp.com/v3/businesses/eaVcCJO5OmBhAv-kJRpWRg").
        #   to_return(body: File.read("./spec/fixtures/business_details_8.json"))
        # stub_request(:get, "https://api.yelp.com/v3/businesses/us9NRKZDQZH0iKgEmdhbJQ").
        #   to_return(body: File.read("./spec/fixtures/business_details_9.json"))
        fill_in "Search for:", with: "Denver, CO"
        click_on "Find Matches"
      end

      it 'should display photos and like and dislike buttons' do

        expect(current_path).to eq("/matches")
        expect(page).to have_css(".photo")
        expect(page).to have_css("input.like", count: 1)
        expect(page).to have_css("input.dislike", count: 1)
        expect(page).to have_css("input.finish", count: 1)
      end
    end

    describe 'when I enter a zip code and click search' do

      before(:each) do
        stub_request(:get, "https://api.yelp.com/v3/businesses/search?limit=20&location=80202&radius=1609&sort_by=distance&term=restaurant").
          to_return(body: File.read("./spec/fixtures/business_search_zip.json"))
        stub_request(:get, "https://api.yelp.com/v3/businesses/idKs48V1lf8LQwvcFJjzGg").
          to_return(body: File.read("./spec/fixtures/business_details_8.json"))
        stub_request(:get, "https://api.yelp.com/v3/businesses/9EBwv92qSn1aFTZ-oK1wag").
          to_return(body: File.read("./spec/fixtures/business_details_9.json"))
        # stub_request(:get, "https://api.yelp.com/v3/businesses/us9NRKZDQZH0iKgEmdhbJQ").
        #   to_return(body: File.read("./spec/fixtures/business_details_6.json"))
        fill_in "Search for:", with: "80202"
        click_on "Find Matches"
      end

      it 'should display photos and like and dislike buttons' do

        expect(current_path).to eq("/matches")
        expect(page).to have_css(".photo")
        expect(page).to have_css("input.like", count: 1)
        expect(page).to have_css("input.dislike", count: 1)
        expect(page).to have_css("input.finish", count: 1)
      end

    end
  end
end
