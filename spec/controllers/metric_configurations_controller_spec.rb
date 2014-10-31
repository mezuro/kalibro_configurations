require 'rails_helper'

RSpec.describe MetricConfigurationsController, :type => :controller do
  let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }

  describe "create" do
    let(:metric_configuration_params) { Hash[FactoryGirl.attributes_for(:metric_configuration,
      kalibro_configuration_id: metric_configuration.kalibro_configuration.id,
      metric_id: metric_configuration.metric.id).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
    describe "with valid params" do
      before :each do
        MetricConfiguration.any_instance.expects(:save).returns(true)

        post :create, metric_configuration: metric_configuration_params, format: :json
      end

      it { is_expected.to respond_with(:created) }

      it 'is expected to return the MetricConfiguration' do
        metric_configuration.id = nil
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_configuration: metric_configuration}.to_json))
      end
    end

    describe "with invalid params" do
      before :each do
        MetricConfiguration.any_instance.expects(:save).returns(false)

        post :create, metric_configuration: metric_configuration_params, format: :json
      end

      it { is_expected.to respond_with(:unprocessable_entity) }

      it 'should return the error description with the metric_configuration' do
        metric_configuration.id = nil
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_configuration: metric_configuration}.to_json))
      end
    end
  end

  describe "update" do
    let(:metric_configuration_params) { Hash[FactoryGirl.attributes_for(:metric_configuration,
      kalibro_configuration_id: metric_configuration.kalibro_configuration.id,
      metric_id: metric_configuration.metric.id).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers

    before :each do
      MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
    end

    context 'with valid attributes' do
      before :each do
        metric_configuration_params.delete('id')
        MetricConfiguration.any_instance.expects(:update).with(metric_configuration_params).returns(true)

        put :update, metric_configuration: metric_configuration_params, id: metric_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:created) }

      it 'is expected to return the metric_configuration' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_configuration: metric_configuration}.to_json))
      end
    end

    context 'with invalid attributes' do
      before :each do
        metric_configuration_params.delete('id')
        MetricConfiguration.any_instance.expects(:update).with(metric_configuration_params).returns(false)

        put :update, metric_configuration: metric_configuration_params, id: metric_configuration.id, format: :json
      end

      it { is_expected.to respond_with(:unprocessable_entity) }

      it 'should return the error description with the metric_configuration' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_configuration: metric_configuration}.to_json))
      end
    end
  end

  describe "destroy" do
    before :each do
      metric_configuration.expects(:destroy).returns(true)
      MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)

      delete :destroy, id: metric_configuration.id, format: :json
    end
    it { is_expected.to respond_with(:no_content)}
  end
end
