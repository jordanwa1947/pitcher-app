require 'rails_helper'

describe MainAddress do
  describe 'Validations' do
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:city) }
  end
end
