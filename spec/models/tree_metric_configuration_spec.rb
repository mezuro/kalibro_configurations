require 'rails_helper'

RSpec.describe TreeMetricConfiguration, :type => :model do
  subject { FactoryGirl.build(:tree_metric_configuration) }

  describe 'associations' do
    it { is_expected.to belong_to(:reading_group) }
    it { is_expected.to have_many(:kalibro_ranges).dependent(:destroy).with_foreign_key('metric_configuration_id') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:aggregation_form) }
    it { is_expected.to validate_presence_of(:weight) }
    it { is_expected.to validate_numericality_of(:weight) }
  end
end
