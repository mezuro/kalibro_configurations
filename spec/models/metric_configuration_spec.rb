require 'rails_helper'

RSpec.describe MetricConfiguration, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:kalibro_configuration) }
    it { is_expected.to belong_to(:metric_snapshot).dependent(:destroy) }
    it { is_expected.to belong_to(:reading_group) }
    it { is_expected.to have_many(:kalibro_ranges).dependent(:destroy) }
  end

  describe 'validations' do
    subject { FactoryGirl.build(:metric_configuration) }
    it { is_expected.to validate_presence_of(:aggregation_form) }
    it { is_expected.to validate_presence_of(:weight) }
    it { is_expected.to validate_numericality_of(:weight) }
    it { is_expected.to validate_presence_of(:kalibro_configuration) }
    it { is_expected.to validate_presence_of(:metric_snapshot) }
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

    describe 'valid_metric_snapshot_code?' do
      let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration) }
      let(:metric_configuration) { FactoryGirl.build(:metric_configuration, kalibro_configuration_id: kalibro_configuration.id, id: 52) }
      let(:metric_configuration_2) { FactoryGirl.build(:metric_configuration, kalibro_configuration_id: kalibro_configuration.id, id: 51) }

      context 'with a valid code' do
        before :each do
          KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)
          kalibro_configuration.expects(:metric_configurations).returns([metric_configuration])
        end

        it 'should return true' do
          expect(metric_configuration.valid_metric_snapshot_code? metric_configuration.metric_snapshot.code).to be_truthy
        end

        it 'should not fill the errors array' do
          metric_configuration.valid_metric_snapshot_code? metric_configuration.metric_snapshot.code
          expect(metric_configuration.errors).to be_empty
        end
      end

      context 'with an invalid code' do
        before :each do
          KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)
          kalibro_configuration.expects(:metric_configurations).returns([metric_configuration, metric_configuration_2])
        end

        it 'should return false' do
          expect(metric_configuration.valid_metric_snapshot_code? metric_configuration.metric_snapshot.code).to be_falsey
        end

        it 'should fill the errors array' do
          metric_configuration.valid_metric_snapshot_code? metric_configuration.metric_snapshot.code
          expect(metric_configuration.errors[:code]).to include("must be unique within a kalibro configuration")
        end
      end
    end
  end
end
