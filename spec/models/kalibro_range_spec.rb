require 'rails_helper'

RSpec.describe KalibroRange, :type => :model do

  describe 'associations' do
    it { is_expected.to belong_to(:reading) }
    it { is_expected.to belong_to(:metric_configuration) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:beginning) }
    it { is_expected.to validate_presence_of(:end) }
    it { is_expected.to validate_presence_of(:metric_configuration) }
    it { is_expected.to validate_presence_of(:reading) }
    it { is_expected.to validate_numericality_of(:beginning) }
    it { is_expected.to validate_numericality_of(:end) }
    it { is_expected.to validate_uniqueness_of(:beginning).
         scoped_to(:metric_configuration_id).with_message("Should be unique within a Metric Configuration") }
  end

  describe 'methods' do
    describe 'as_json' do
      subject { FactoryGirl.build(:kalibro_range_with_id) }

      context 'with numbers' do
        it 'is expected to convert the numbers to strings' do
          expect(KalibroRange.new(subject.as_json)).to eq(subject)
        end
      end

      context 'with positive infinity beginning' do
        before do
          subject.beginning = Float::INFINITY
        end

        it 'is expected to convert to INF' do
          expect(subject.as_json["beginning"]).to eq("INF")
        end
      end

      context 'with negative infinity beginning' do
        before do
          subject.beginning = -Float::INFINITY
        end

        it 'is expected to convert to -INF' do
          expect(subject.as_json["beginning"]).to eq("-INF")
        end
      end

      context 'with positive infinity end' do
        before do
          subject.end = Float::INFINITY
        end

        it 'is expected to convert to INF' do
          expect(subject.as_json["end"]).to eq("INF")
        end
      end

      context 'with negative infinity end' do
        before do
          subject.end = -Float::INFINITY
        end

        it 'is expected to convert to -INF' do
          expect(subject.as_json["end"]).to eq("-INF")
        end
      end
    end
  end
end
