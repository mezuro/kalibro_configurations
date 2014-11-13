require 'rails_helper'

RSpec.describe MetricSnapshotsController, :type => :controller do
  let(:metric_snapshot) { FactoryGirl.build(:metric_snapshot) }

  describe 'index' do
    let!(:metric_snapshots) { [metric_snapshot] }

    before :each do
      MetricSnapshot.expects(:all).returns(metric_snapshots)

      get :index, format: :json
    end

    it { is_expected.to respond_with(:success) }

    it 'is expected to return the list of metric_snapshots converted to JSON' do
      expect(JSON.parse(response.body)).to eq(JSON.parse({metric_snapshots: metric_snapshots}.to_json))
    end
  end

  describe 'show' do
    context 'when the MetricSnapshot exists' do
      before :each do
        MetricSnapshot.expects(:find).with(metric_snapshot.id).returns(metric_snapshot)

        get :show, id: metric_snapshot.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return the list of metric_snapshots converted to JSON' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_snapshot: metric_snapshot}.to_json))
      end
    end

    context 'when the MetricSnapshot does not exist' do
      before :each do
        MetricSnapshot.expects(:find).with(metric_snapshot.id).raises(ActiveRecord::RecordNotFound)

        get :show, id: metric_snapshot.id, format: :json
      end

      it { is_expected.to respond_with(:unprocessable_entity) }

      it 'should return the error description' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({error: 'RecordNotFound'}.to_json))
      end
    end
  end

  describe 'create' do
    let(:metric_snapshot_params) { Hash[FactoryGirl.attributes_for(:metric_snapshot).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers

    before do
      metric_snapshot_params.delete('id')
    end

    context 'with valid attributes' do
      before :each do
        MetricSnapshot.any_instance.expects(:save).returns(true)

        post :create, metric_snapshot: metric_snapshot_params, format: :json
      end

      it { is_expected.to respond_with(:created) }

      it 'is expected to return the metric_snapshot' do
        metric_snapshot.id = nil
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_snapshot: metric_snapshot}.to_json))
      end
    end

    context 'with invalid attributes' do
      before :each do
        MetricSnapshot.any_instance.expects(:save).returns(false)

        post :create, metric_snapshot: metric_snapshot_params, format: :json
      end

      it { is_expected.to respond_with(:unprocessable_entity) }

      it 'should return the error description with the metric_snapshot' do
        metric_snapshot.id = nil
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_snapshot: metric_snapshot}.to_json))
      end
    end
  end

  describe 'update' do
    let(:metric_snapshot_params) { Hash[FactoryGirl.attributes_for(:metric_snapshot).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers

    before :each do
      MetricSnapshot.expects(:find).with(metric_snapshot.id).returns(metric_snapshot)
    end

    context 'with valid attributes' do
      before :each do
        metric_snapshot_params.delete('id')
        MetricSnapshot.any_instance.expects(:update).with(metric_snapshot_params).returns(true)

        put :update, metric_snapshot: metric_snapshot_params, id: metric_snapshot.id, format: :json
      end

      it { is_expected.to respond_with(:success) }

      it 'is expected to return the metric_snapshot' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_snapshot: metric_snapshot}.to_json))
      end
    end

    context 'with invalid attributes' do
      before :each do
        metric_snapshot_params.delete('id')
        MetricSnapshot.any_instance.expects(:update).with(metric_snapshot_params).returns(false)

        put :update, metric_snapshot: metric_snapshot_params, id: metric_snapshot.id, format: :json
      end

      it { is_expected.to respond_with(:unprocessable_entity) }

      it 'should return the error description with the metric_snapshot' do
        expect(JSON.parse(response.body)).to eq(JSON.parse({metric_snapshot: metric_snapshot}.to_json))
      end
    end
  end

  describe 'destroy' do
    before :each do
      metric_snapshot.expects(:destroy).returns(true)
      MetricSnapshot.expects(:find).with(metric_snapshot.id).returns(metric_snapshot)

      delete :destroy, id: metric_snapshot.id, format: :json
    end

    it { is_expected.to respond_with(:no_content) }
  end
end
