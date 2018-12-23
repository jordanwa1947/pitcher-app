require 'rails_helper'

describe 'user visits dashboard page' do
  it 'allows them to enter a main address' do
    VCR.use_cassette('geocode_lookup') do
      user = User.create(email: 'jawesome@gmail.com', first_name: 'Jordan',
                         last_name: 'Awesome', uid: '12345')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      fill_in 'main_address[address]', with: '17th St LL100'
      fill_in 'main_address[city]', with: 'Denver'
      fill_in 'main_address[state]', with: 'CO'
      fill_in 'main_address[zip]', with: '80202'
      click_on 'Submit'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('success: Main Address Updated')
      expect(page).to have_content('Address: 17th St LL100')
      expect(page).to have_content('City: Denver')
      expect(page).to have_content('State: CO')
      expect(page).to have_content('Zip Code: 80202')
    end
  end
end
