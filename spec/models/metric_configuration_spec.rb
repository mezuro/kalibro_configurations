require 'rails_helper'

RSpec.describe MetricConfiguration, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:kalibro_configuration) }
    it { is_expected.to have_many(:kalibro_ranges) }
  end
end
