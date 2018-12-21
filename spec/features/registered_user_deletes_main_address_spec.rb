require 'rails_helper'

describe 'Registered User Deletes Main Address' do
  it 'deletes their main address' do
    user = User.create(email: 'jawesome@gmail.com', first_name: 'Jordan',
                       last_name: 'Awesome', uid: '12345')
    prime_address = MainAddress.create(address: '17th St LL100',
                                      state: 'CO',
                                      city: 'Denver',
                                      zip: '80202',
                                      user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    click_link 'Delete Main Address'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_field 'main_address[city]'
    expect(page).to have_field 'main_address[state]'
    expect(page).to have_field 'main_address[address]'
    expect(page).to have_field 'main_address[zip]'

  end
end
