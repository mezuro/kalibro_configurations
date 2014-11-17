require 'rails_helper'

RSpec.describe MetricConfiguration, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:kalibro_configuration) }
    it { is_expected.to belong_to(:metric_snapshot).dependent(:destroy) }
    it { is_expected.to have_many(:kalibro_ranges).dependent(:destroy) }
  end

  describe 'validations' do
    subject { FactoryGirl.build(:metric_configuration) }
    it { is_expected.to validate_presence_of(:aggregation_form) }
    it { is_expected.to validate_presence_of(:weight) }
    it { is_expected.to validate_numericality_of(:weight) }
    it { is_expected.to validate_presence_of(:kalibro_configuration) }
    it { is_expected.to validate_presence_of(:metric_snapshot) }
    it 'is pending' do
      pending 'waiting for bug fix on shoulda-matchers (https://github.com/thoughtbot/shoulda-matchers/issues/535)'
      is_expected.to validate_uniqueness_of(:metric_snapshot).
        scoped_to(:kalibro_configuration_id).with_message("Should be unique within a Kalibro Configuration")
    end
    it { is_expected.to accept_nested_attributes_for(:metric_snapshot) }
  end
end
