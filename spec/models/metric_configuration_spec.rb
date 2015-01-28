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

  describe 'methods' do
    describe 'as_json' do
      subject { FactoryGirl.build(:metric_configuration) }

      context 'with a NativeMetricSnapshot' do
        let!(:metric_snapshot) { FactoryGirl.build(:native_metric_snapshot) }

        before do
          subject.metric_snapshot = metric_snapshot
        end

        it 'is expected to set the metric attribute from hash' do
          metric_snapshot_json = metric_snapshot.as_json(except: [:id, :created_at, :updated_at])
          metric_snapshot_json['type'] = 'NativeMetricSnapshot'
          expect(subject.as_json['metric']).to eq(metric_snapshot_json)
        end
      end

      context 'with a CompoundMetricSnapshot' do
        let!(:metric_snapshot) { FactoryGirl.build(:compound_metric_snapshot) }

        before do
          subject.metric_snapshot = metric_snapshot
        end

        it 'is expected to set the metric attribute from hash' do
          metric_snapshot_json = metric_snapshot.as_json(except: [:id, :created_at, :updated_at])
          metric_snapshot_json['type'] = 'CompoundMetricSnapshot'
          expect(subject.as_json['metric']).to eq(metric_snapshot_json)
        end
      end
    end
  end
end
