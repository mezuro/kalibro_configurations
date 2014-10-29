require 'rails_helper'

RSpec.describe Reading, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:reading_group)}
    it { is_expected.to have_many(:kalibro_ranges)}
  end
end
