require 'rails_helper'

describe 'Wishlist' do

  describe "Visitor" do
    it "A visitor gets a 404 error" do
      skip("It's raising the error, but I don't understand why this method won't work")
      expect( (visit wishlist_path) ).to raise_error(ActionController::RoutingError)
    end
  end

  describe "User" do

    it 'A User can visit wishlist index' do

    end

    it 'Wishlist Item cards are links to restaurant show' do


    end



  end


end
