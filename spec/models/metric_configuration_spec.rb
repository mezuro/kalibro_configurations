require 'rails_helper'

RSpec.describe MetricConfiguration, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:kalibro_configuration) }
    it { is_expected.to belong_to(:metric_snapshot) }
    it { is_expected.to have_many(:kalibro_ranges).dependent(:destroy) }
  end

  describe 'validations' do
    let!(:kalibro_configuration) {FactoryGirl.build(:kalibro_configuration)}
    before :each do
      KalibroConfiguration.expects(:find).twice.returns(kalibro_configuration)
    end
    it { is_expected.to validate_presence_of(:aggregation_form) }
    it { is_expected.to validate_presence_of(:weight) }
    it { is_expected.to validate_presence_of(:kalibro_configuration) }
    it { is_expected.to validate_presence_of(:metric_snapshot) }
  end

  describe 'destroy' do
    context 'it refers to a CompoundMetric' do
      let!(:compound_metric){ FactoryGirl.build(:compound_metric) }
      subject { FactoryGirl.build(:metric_configuration, metric: compound_metric) }

      it 'is expected to destroy that metric as well' do
        compound_metric.expects(:destroy).returns(true)

        subject.destroy
      end
    end
  end
end
