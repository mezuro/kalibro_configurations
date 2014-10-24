require 'rails_helper'

RSpec.describe ReadingGroup, :type => :model do
  describe 'associations' do
    it { is_expected.to have_many(:readings)}
  end
end
