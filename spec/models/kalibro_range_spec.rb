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
end
