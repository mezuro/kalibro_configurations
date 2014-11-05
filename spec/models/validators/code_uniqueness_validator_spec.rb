require 'rails_helper'

describe CodeUniquenessValidator, :type => :model do
  describe 'methods' do
    describe 'validate' do
      subject { FactoryGirl.build(:metric_configuration) }
      let!(:kalibro_configuration) {FactoryGirl.build(:kalibro_configuration)}
      context 'without saved metric_configurations' do
        before :each do
          KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)
          kalibro_configuration.expects(:metric_configurations).returns([])
        end

        it 'should contain no errors' do
          subject.save
          expect(subject.errors).to be_empty
        end
      end

      context 'with code already taken by another metric_configuration' do
        let!(:metric_configuration) { FactoryGirl.build(:metric_configuration, id: subject.id + 1) }
        before :each do
          KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns(kalibro_configuration)
          kalibro_configuration.expects(:metric_configurations).returns([metric_configuration])
        end

        it 'should contain errors' do
          subject.save
          expect(subject.errors[:code]).to include("There is already a metric snapshot with the code #{metric_configuration.metric_snapshot.code}! Please, choose another one.")
        end
      end
    end
  end
end
