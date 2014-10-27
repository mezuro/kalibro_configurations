require 'rails_helper'

RSpec.describe KalibroConfiguration, :type => :model do
  describe 'metric_configurations_of' do
    let!(:metric_configuration) { FactoryGirl.create(:metric_configuration) }
    let!(:kalibro_configuration) { FactoryGirl.create(:kalibro_configuration, metric_configurations: [metric_configuration]) }

    it 'should return a list of metric configurations' do
      expect(KalibroConfiguration.metric_configurations_of(kalibro_configuration.id)).to eq([metric_configuration])
    end
  end
end
