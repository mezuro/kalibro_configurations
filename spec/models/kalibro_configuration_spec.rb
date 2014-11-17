require 'rails_helper'

RSpec.describe KalibroConfiguration, :type => :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:metric_configurations).dependent(:destroy) }
  end
end
