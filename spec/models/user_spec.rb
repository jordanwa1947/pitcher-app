require 'rails_helper'

describe User, type: :model do

  describe 'Relationships' do
    it { should have_one :main_address }
    it { should have_many :wishlists }
    it { should have_many :visits }
    it { should have_many :reviews }
  end

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

    it '.default_city' do
      expect(@user.default_city).to eq('Denver, CO')
    end

  end
end
