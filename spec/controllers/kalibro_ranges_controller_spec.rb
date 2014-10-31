require 'rails_helper'

RSpec.describe KalibroRangesController, :type => :controller do

  let!(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
  let!(:reading) { FactoryGirl.create(:reading) }
  let!(:range) { FactoryGirl.build(:kalibro_range, metric_configuration_id: metric_configuration.id, reading_id: reading.id) }

  describe 'create' do
    let!(:range_params) { Hash[FactoryGirl.attributes_for(:kalibro_range, metric_configuration_id: metric_configuration.id, reading_id: reading.id).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
    context 'successfully saved' do
      before :each do
        KalibroRange.any_instance.expects(:save).returns(true)
      end

      context 'json format' do
        before :each do
          post :create, metric_configuration_id: metric_configuration.id, kalibro_range: range_params, format: :json
        end

        it { is_expected.to respond_with(:created) }

        it 'returns the range' do
          range.id = nil
          expect(JSON.parse(response.body)).to eq(JSON.parse({kalibro_range: range}.to_json))
        end
      end
    end

    context 'failed to save' do
      before :each do
        KalibroRange.any_instance.expects(:save).returns(false)
      end

      context 'json format' do
        before :each do
          post :create, metric_configuration_id: metric_configuration.id, kalibro_range: range_params, format: :json
        end

        it { is_expected.to respond_with(:unprocessable_entity) }

        it 'returns range' do
          range.id = nil
          expect(JSON.parse(response.body)).to eq(JSON.parse({kalibro_range: range}.to_json))
        end
      end
    end
  end

  describe 'update' do
    let!(:range_params) { Hash[FactoryGirl.attributes_for(:kalibro_range, metric_configuration_id: metric_configuration.id, reading_id: reading.id).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers

    before :each do
      KalibroRange.expects(:find).with(range.id).returns(range)
    end

    context 'successfully updated' do
      before :each do
        KalibroRange.any_instance.expects(:update).with(range_params).returns(true)
      end

      context 'json format' do
        before :each do
          range_params.delete('id')
          put :update, metric_configuration_id: metric_configuration.id, kalibro_range: range_params, id: range.id, format: :json
        end

        it { is_expected.to respond_with(:created) } #TODO change :created response

        it 'returns the range' do
          expect(JSON.parse(response.body)).to eq(JSON.parse({kalibro_range: range}.to_json))
        end
      end
    end

    context 'failed to update' do
      before :each do
        KalibroRange.any_instance.expects(:update).with(range_params).returns(false)
      end

      context 'json format' do
        before :each do
          range_params.delete('id')
          post :update, metric_configuration_id: metric_configuration.id, kalibro_range: range_params, id: range.id, format: :json
        end

        it { is_expected.to respond_with(:unprocessable_entity) }

        it 'returns range' do
          expect(JSON.parse(response.body)).to eq(JSON.parse({kalibro_range: range}.to_json))
        end
      end
    end
  end

  describe 'destroy' do
    context 'with and existent range' do
      before :each do
        KalibroRange.expects(:find).with(range.id).returns(range)
      end

      context 'json format' do
        before :each do
          range.expects(:destroy).returns(true)
          delete :destroy, metric_configuration_id: metric_configuration.id, id: range.id, format: :json
        end

        it { is_expected.to respond_with(:success) }

        it 'returns an empty hash' do
          expect(JSON.parse(response.body)).to eq(JSON.parse({}.to_json))
        end
      end
    end
  end
end

