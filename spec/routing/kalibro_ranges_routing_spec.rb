require "rails_helper"

RSpec.describe KalibroRangesController, :type => :routing do
  describe "routing" do

    it "routes to #destroy" do
      expect(:delete => "/metric_configurations/3/kalibro_ranges/1").to route_to("kalibro_ranges#destroy", :metric_configuration_id => "3", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/metric_configurations/3/kalibro_ranges").to route_to("kalibro_ranges#create", :metric_configuration_id => "3")
    end

    it "routes to #update" do
      expect(:put => "/metric_configurations/3/kalibro_ranges/1").to route_to("kalibro_ranges#update", :metric_configuration_id => "3", :id => "1")
    end

    it "routes to #ranges_of" do
      expect(:get => "/metric_configurations/2/kalibro_ranges").to route_to("kalibro_ranges#of", :metric_configuration_id => "2")
    end

  end
end
