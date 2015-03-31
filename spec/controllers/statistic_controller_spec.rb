require 'rails_helper'

RSpec.describe StatisticController, type: :controller do

  describe "GET #count_metric_configuration" do
    it "returns http success" do
      get :count_metric_configuration
      expect(response).to have_http_status(:success)
    end
  end

end
