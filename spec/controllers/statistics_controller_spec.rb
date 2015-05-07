require 'rails_helper'
RSpec.describe StatisticsController, type: :controller do
  # let(:statistic) { metric_percentage: 100 }

  describe "GET #count_metric for an used metric" do
    
    before :each do
      MetricConfiguration.expects(:all).returns([1, 2, 3])
      MetricSnapshot.expects(:where).returns([1])
      get :count_metric, metric_code: 'loc', format: :json
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns the statistics of an existing metric" do  
      expect(JSON.parse(response.body)).to eq(JSON.parse({ metric_percentage: 33.33 }.to_json))
    end
  end

  describe "GET #count_metric with no metric configurations in the database" do
    before :each do
      MetricConfiguration.expects(:all).returns([])
      MetricSnapshot.expects(:where).returns([])
      get :count_metric, metric_code: 'loc', format: :json
    end

    it "returns http success with no metric configurations in the database" do
      expect(response).to have_http_status(:success)
    end

    it "returns zero for empty metric configurations database" do  
      expect(JSON.parse(response.body)).to eq(JSON.parse({ metric_percentage: 0.0 }.to_json))
    end
  end

  describe "GET #count_metric for a metric that has not been used yet" do
    before :each do
      MetricConfiguration.expects(:all).returns([1, 2, 3])
      MetricSnapshot.expects(:where).returns([])
      get :count_metric, metric_code: 'loc', format: :json
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns zero percent for metric not used yet" do  
      expect(JSON.parse(response.body)).to eq(JSON.parse({ metric_percentage: 0.0 }.to_json))
    end
  end
  
end