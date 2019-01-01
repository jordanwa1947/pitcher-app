require 'rails_helper'

describe 'Google Oauth' do
  it 'takes the user to google to signin and redirects back to dashboard' do
    stub_omniauth

    visit '/'
    click_link("Login with Google")

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("You've Successfully Logged In!")
  end

  it 'allows the user to logout after' do
    stub_omniauth

    visit '/'
    click_link("Login with Google")

    expect(current_path).to eq('/dashboard')

    click_link 'Logout'

    expect(current_path).to eq('/')
  end
end
