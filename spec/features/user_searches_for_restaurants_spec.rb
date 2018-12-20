require 'rails_helper'

describe 'As a registered user' do

  before(:each) do
    user = create(:user)
    address = create(:main_address, user: user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe 'when I visit the restaurant search path' do

    before(:each) do
      visit dashboard_path
    end

    it 'should display a button to search using my main address' do
      expect(page).to have_content("Use My Home Address")
    end

    describe 'when I click the Use My Home Address button' do

      it 'should display a photo and like and dislike buttons' do

        within(".nav") do
          click_button("Use My Home Address")
        end
  
        expect(current_path).to eq("images_path")
        expect(page).to have_css(".photo", count: 1)
        expect(page).to have_css("button.like", count: 1)
        expect(page).to have_css("button.dislike", count: 1)
        expect(page).to have_css("button.finish", count: 1)
      end

    end
  end
end