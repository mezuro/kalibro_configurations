require "rails_helper"

RSpec.describe MezuroRangesController, :type => :routing do
  describe "routing" do

    it "routes to #destroy" do
      expect(:delete => "/mezuro_ranges/1").to route_to("mezuro_ranges#destroy", :id => "1")
    end
    
    it "routes to #save" do
      expect(:post => "/mezuro_ranges").to route_to("mezuro_ranges#save")
    end
    
    it "routes to #ranges_of" do
      expect(:get => "/metric_configuration/1/ranges_of").to route_to("mezuro_ranges#ranges_of", :id => "1")
    end

  end
end
