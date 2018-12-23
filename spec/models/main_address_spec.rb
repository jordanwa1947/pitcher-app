require 'rails_helper'

describe MainAddress do
  describe 'Validations' do
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:city) }
  end

  it 'uses geocoder to lookup coordinates for an address' do
    VCR.use_cassette('geocode_lookup') do
      user = create(:user)
      main_address = create(:main_address, user: user)
 
      expect(main_address.longitude.class).to eq(Float)
      expect(main_address.longitude.class).to eq(Float)
    end
  end
end
