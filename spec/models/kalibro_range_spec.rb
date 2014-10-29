require 'rails_helper'

RSpec.describe KalibroRange, :type => :model do

  describe 'ranges_of' do
    let!(:ranges) { [FactoryGirl.build(:kalibro_range)] }
    let!(:metric_configuration) { FactoryGirl.create(:metric_configuration, kalibro_ranges: ranges) }

    it 'should return a list of ranges' do
      expect(KalibroRange.ranges_of(metric_configuration.id)).to eq(ranges)
    end

  end

  describe 'associations' do
    it { is_expected.to belong_to(:reading) }
    it { is_expected.to belong_to(:metric_configuration) }
  end
end
