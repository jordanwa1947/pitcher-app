require 'rails_helper'

describe Restaurant, type: :model do

  describe 'Relationships' do
    it { should have_many :wishlists }
    it { should have_many :reviews }
    it { should have_many :photos }
  end

  describe 'Validations' do
    it { should validate_uniqueness_of :yelp_id }
  end
end