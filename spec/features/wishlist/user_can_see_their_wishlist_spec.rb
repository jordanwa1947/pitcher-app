require 'rails_helper'

describe 'Wishlist' do

  describe "Visitor" do
    it "A visitor gets redirect to the root path" do
      visit wishlist_path
      expect(page).to have_current_path(root_path)
    end
  end

  describe "User" do

    it 'A User can visit wishlist index' do

    end

    it 'Wishlist Item cards are links to restaurant show' do


    end



  end


end
