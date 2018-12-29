require 'rails_helper'

describe Restaurant, type: :model do

  describe 'Relationships' do
    it { should have_many :wishlists }
    it { should have_many :reviews }
  end
end