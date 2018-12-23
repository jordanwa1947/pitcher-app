require 'rails_helper'

describe 'Registered User with clicks on update main address' do
  it "let's updates their address after they fill out the form" do
    VCR.use_cassette('geocode_lookup', record: :all) do
      user = User.create(email: 'jawesome@gmail.com', first_name: 'Jordan',
                         last_name: 'Awesome', uid: '12345')
      prime_address = MainAddress.create(address: '17th St LL100',
                                        state: 'CO',
                                        city: 'Denver',
                                        zip: '80202',
                                        user_id: user.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      click_link 'Update Main Address'

      expect(current_path).to eq(edit_user_main_address_path(user, user.main_address))

      fill_in 'main_address[city]', with: 'Tampa'
      fill_in 'main_address[state]', with: 'Fl'
      click_on 'Submit'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('City: Tampa')
      expect(page).to have_content('State: Fl')
      expect(page).to have_content('Zip Code: 80202')
      expect(page).to_not have_content('State: CO')
      expect(page).to_not have_content('City: Denver')
    end
  end
end
