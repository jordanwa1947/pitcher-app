require 'rails_helper'

describe Review, type: :model do

  let(:user)       { create(:user) }
  let(:restaurant) { create(:restaurant) }
  let(:review)     { create(:review, user: user, restaurant: restaurant) }

  describe 'Relationships' do
    it { should belong_to :restaurant }
    it { should belong_to :user }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :review }

    it 'validates only one review per user-restaurant pair' do
      validate_uniqueness_of(user).scoped_to(:restaurant)
      validate_uniqueness_of(:user).scoped_to(restaurant)
    end

  end

  describe "Methods" do

    it "gets author name" do
      author = review.author
      # binding.pry
      expect(author).to eq(user.first_name)
    end

  end


end
