Given(/^I have a sample kalibro configuration$/) do
  @kalibro_configuration = FactoryGirl.create(:kalibro_configuration)
end

When(/^I ask for the metric configurations of the sample kalibro configuration$/) do
  @response = @kalibro_configuration.metric_configurations
end

When(/^I ask for the tree metric configurations of the sample kalibro configuration$/) do
  @response = @kalibro_configuration.tree_metric_configurations
end

When(/^I ask for the hotspot metric configurations of the sample kalibro configuration$/) do
  @response = @kalibro_configuration.hotspot_metric_configurations
end

Then(/^I should not get any metric configuration$/) do
  expect(@response).to be_empty
end
