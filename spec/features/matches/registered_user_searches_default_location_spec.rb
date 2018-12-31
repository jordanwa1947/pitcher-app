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
      visit dashboard_path
    end

    it 'should display a button to search using my main address' do
      expect(page).to have_content("Default Location")
    end

    describe 'when I click the Default Location button' do

      before(:each) do
        stub_business_search
        stub_business_1
        stub_business_2
        stub_business_3
        click_on "Default Location"
      end

      it 'should display photos and like and dislike buttons' do
        expect(current_path).to eq("/matches")
        expect(page).to have_css(".photo")
        expect(page).to have_css("input.like",    count: 1)
        expect(page).to have_css("input.dislike", count: 1)
        expect(page).to have_css("input.finish",  count: 1)
      end

      describe "when I click the like button" do

        before(:each) do
          click_on "Like"
        end

        it "should display a new set of photos" do
          expect(current_path).to eq("/matches")
          expect(page).to have_css(".photo")
        end

        describe "when I click the finish button" do

          before(:each) do
            click_on "Finish"
          end

          it "should display restaurant info in my wishlist" do
            expect(page).to have_content("These are all the restaurants you've been interested in from the past.")
            expect(page).to have_css("h4.restaurant-name", count: 1)
            expect(page).to have_css("li.restaurant-address", count: 1)
            expect(page).to have_css("li.restaurant-phone", count: 1)
            expect(page).to have_css("a.restaurant-yelp_link", count: 1)
            expect(page).to have_css("img.photo", count: 1)
          end
        end
      end

      describe "when I click the dislike button" do

        before(:each) do
          click_on "Pass"
        end

        it "should display a new set of photos" do
          expect(current_path).to eq("/matches")
          expect(page).to have_css(".photo")
        end

        describe "when I click the finish button" do

          before(:each) do
            click_on "Finish"
          end

          it "should not display restaurant info in my wishlist" do
            expect(page).to have_content("You don't have any recommended restaurants yet.")
            expect(page).to_not have_css("li.restaurant_name", count: 1)
          end
        end
      end

    end
  end
end
