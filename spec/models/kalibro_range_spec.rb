require 'rails_helper'

RSpec.describe KalibroRange, :type => :model do

  describe 'associations' do
    it { is_expected.to belong_to(:reading) }
    it { is_expected.to belong_to(:metric_configuration) }
  end
end
