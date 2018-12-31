require 'rails_helper'

describe Restaurant, type: :model do

  describe 'Relationships' do
    it { should have_many :wishlists }
    it { should have_many :reviews }
  end

  describe 'Validations' do
    it { should validate_presence_of :longitude }
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :yelp_link }
    it { should validate_presence_of :address }
    it { should validate_presence_of :name }
    it { should validate_presence_of :city }

    it { should validate_presence_of   :yelp_id }
    it { should validate_uniqueness_of :yelp_id }
  end

end
