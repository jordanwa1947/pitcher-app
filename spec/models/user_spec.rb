require 'rails_helper'

describe 'User' do
  describe 'Instance Methods' do

    before(:each) do
      VCR.use_cassette('geocode_lookup', record: :all) do
        @user = User.create(email: 'jawesome@gmail.com',
                           first_name: 'Jordan',
                           last_name: 'Awesome',
                           uid: '12345')
        @prime_address = MainAddress.create(address: '17th St LL100',
                                          state: 'CO',
                                          city: 'Denver',
                                          zip: '80202',
                                          user_id: @user.id)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end
    end

    it '.build address' do
      expect(@user.build_address).to eq('17th St LL100 Denver CO 80202')
    end

    it '.local_restaurants' do
      VCR.use_cassette("user_local_restaurants_spec", record: :all) do
        restaurants = @user.local_restaurants(@user.build_address)
        expect(restaurants).to be_a(Hash)
        expect(restaurants.keys.count).to eq(20)
      end
    end
  end
end
