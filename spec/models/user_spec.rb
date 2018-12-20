require 'rails_helper'

describe 'User' do

  describe 'Instance Methods' do
    it '.build address' do
      user = User.create(email: 'jawesome@gmail.com', first_name: 'Jordan',
                         last_name: 'Awesome', uid: '12345')
      prime_address = MainAddress.create(address: '17th St LL100',
                                        state: 'CO',
                                        city: 'Denver', 
                                        zip: '80202',
                                        user_id: user.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(user.build_address).to eq('17th St LL100 Denver CO 80202')
    end
  end
end
