require 'rails_helper'

describe Photo, type: :model do

  describe 'Relationships' do

    it { should belong_to :restaurant }

  end
  
end