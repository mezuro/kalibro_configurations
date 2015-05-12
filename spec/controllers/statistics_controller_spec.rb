require 'rails_helper'
RSpec.describe StatisticsController, type: :controller do

  describe "GET #metric_percentage for an used metric" do
    
    before :each do
      MetricConfiguration.expects(:all).returns([FactoryGirl.build(:metric_configuration),
        FactoryGirl.build(:metric_configuration),FactoryGirl.build(:metric_configuration)])
      MetricSnapshot.expects(:where).returns([FactoryGirl.build(:metric_snapshot)])
      get :metric_percentage, metric_code: 'loc', format: :json
    end

    it {should respond_with(:success)}

    it "returns the statistics of an existing metric" do  
      expect(JSON.parse(response.body)).to eq(JSON.parse({ metric_percentage: 33.33 }.to_json))
    end
  end

  describe "GET #metric_percentage with no metric configurations in the database" do
    before :each do
      MetricConfiguration.expects(:all).returns([])
      MetricSnapshot.expects(:where).returns([])
      get :metric_percentage, metric_code: 'loc', format: :json
    end

    it {should respond_with(:success)}

    it "returns zero for empty metric configurations database" do  
      expect(JSON.parse(response.body)).to eq(JSON.parse({ metric_percentage: 0.0 }.to_json))
    end
  end

  describe "GET #metric_percentage for a metric that has not been used yet" do
    before :each do
      MetricConfiguration.expects(:all).returns([FactoryGirl.build(:metric_configuration),
        FactoryGirl.build(:metric_configuration),FactoryGirl.build(:metric_configuration)])
      MetricSnapshot.expects(:where).returns([])
      get :metric_percentage, metric_code: 'loc', format: :json
    end

    it {should respond_with(:success)}

    it "returns zero percent for metric not used yet" do  
      expect(JSON.parse(response.body)).to eq(JSON.parse({ metric_percentage: 0.0 }.to_json))
    end
  end
  
end