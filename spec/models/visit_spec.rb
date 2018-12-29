require 'rails_helper' do
  describe Visit, type: :model do
    it { should belong_to :user }
    it { should belong_to :restaurant }
  end
end