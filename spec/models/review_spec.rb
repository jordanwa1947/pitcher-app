require 'rails_helper'

describe Review, type: :model do

  describe 'Relationships' do
    it { should belong_to :restaurant }
    it { should belong_to :user }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :review }
  end

end
