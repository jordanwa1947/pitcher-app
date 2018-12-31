require 'rails_helper'

describe 'Visitor' do

  before(:each) do
    visit root_path
  end

  it 'sees the nav bar' do
    expect(page).to have_css('.nav')
  end

  it 'does not see user links' do
    expect(page).to_not have_content("Wishlist")
    expect(page).to_not have_content("Recent Matches")
  end

end


describe "User" do

  let(:user) { User.create(first_name: "First", last_name: "Last", email: "email") }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
  end

  it 'can click Wishlist link' do
    expect(page).to have_css('.nav')
    within('.nav') do
      click_link "Wishlist"
    end
    expect(page).to have_current_path(wishlist_path)
    expect(page).to have_css('.nav')
  end

  it 'can click Visited link' do
    expect(page).to have_css('.nav')
    within('.nav') do
      click_link "Visited"
    end
    expect(page).to have_current_path('/visited')
    expect(page).to have_css('.nav')
  end

  # it 'can click Matches link' do
  #   within('.nav') do
  #     click_link "Wishlist"
  #   end
  #   expect(page).to have_current_path(wishlist_path)
  #   expect(page).to have_css('.nav')
  # end




end
