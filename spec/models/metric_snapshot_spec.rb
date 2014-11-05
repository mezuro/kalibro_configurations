require 'rails_helper'

RSpec.describe MetricSnapshot, :type => :model do
  describe 'associations' do
    it { is_expected.to have_one(:metric_configuration) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:scope) }
  end
end
